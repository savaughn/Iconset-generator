#include <gtk/gtk.h>
#include <stdlib.h>
#include <string.h>

// TODO: Get all of this out of main.c

typedef struct
{
    GtkWidget *window;
    GtkWidget *image;
    GtkWidget *grid;
    GtkWidget *checkboxes[10];
    char *file_path;
} AppWidgets;

const char *sizes[] = {
    "icon_16x16", "16",
    "icon_16x16@2x", "32",
    "icon_32x32", "32",
    "icon_32x32@2x", "64",
    "icon_128x128", "128",
    "icon_128x128@2x", "256",
    "icon_256x256", "256",
    "icon_256x256@2x", "512",
    "icon_512x512", "512",
    "icon_512x512@2x", "1024"};

void resize_images(AppWidgets *widgets)
{
    char command[1024];
    char output_dir[1024];
    snprintf(output_dir, sizeof(output_dir), "%s/generated", g_path_get_dirname(widgets->file_path));
    g_mkdir_with_parents(output_dir, 0755);

    for (int i = 0; i < 10; i++)
    {
        if (gtk_check_button_get_active(GTK_CHECK_BUTTON(widgets->checkboxes[i])))
        {
            // TODO: Integrate this with the ImageMagick API instead of using system()
            snprintf(command, sizeof(command), "magick \"%s\" -resize %sx%s! \"%s/%s.png\"",
                     widgets->file_path, sizes[i * 2 + 1], sizes[i * 2 + 1], output_dir, sizes[i * 2]);
            system(command);
        }
    }

    GtkWidget *dialog = gtk_message_dialog_new(GTK_WINDOW(widgets->window),
                                               GTK_DIALOG_DESTROY_WITH_PARENT,
                                               GTK_MESSAGE_INFO,
                                               GTK_BUTTONS_OK,
                                               "Resizing completed. Resized images are in the 'generated' directory.");
    gtk_window_present(GTK_WINDOW(dialog));
    g_signal_connect(dialog, "response", G_CALLBACK(gtk_window_destroy), NULL);
}

static gboolean on_file_dropped(GtkDropTarget *target, const GValue *value,
                                double x,
                                double y,
                                gpointer data)
{
    /* GdkFileList is a boxed value so we use the boxed API. */
    GdkFileList *file_list = g_value_get_boxed(value);

    AppWidgets *widgets = (AppWidgets *)data;

    GSList *list = gdk_file_list_get_files(file_list);

    /* Loop through the files and print their names. */
    for (GSList *l = list; l != NULL; l = l->next)
    {
        GFile *file = l->data;
        // TODO: obvi only 1 file dropped at a time rn
        widgets->file_path = g_file_get_path(file);
    }

    return TRUE;
}

void activate(GtkApplication *app, gpointer user_data)
{
    AppWidgets *widgets = g_malloc(sizeof(AppWidgets));

    widgets->window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(widgets->window), "Image Resizer");
    gtk_window_set_default_size(GTK_WINDOW(widgets->window), 400, 300);

    GtkWidget *vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
    gtk_window_set_child(GTK_WINDOW(widgets->window), vbox);

    widgets->image = gtk_image_new();
    gtk_widget_set_size_request(widgets->image, -1, 200);
    gtk_box_append(GTK_BOX(vbox), widgets->image);

    GtkDropTarget *target = gtk_drop_target_new(G_TYPE_INVALID, GDK_ACTION_COPY);

    gtk_drop_target_set_gtypes(target, (GType[1]){
                                           GDK_TYPE_FILE_LIST,
                                       },
                               1);

    g_signal_connect(target, "drop", G_CALLBACK(on_file_dropped), widgets);
    gtk_widget_add_controller(GTK_WIDGET(widgets->window), GTK_EVENT_CONTROLLER(target));

    // TODO: Add on_enter and on_leave signals to change the background color of the drop target 

    GtkCssProvider *provider = gtk_css_provider_new();
    const char *drop_target_css = "#drop-target { background-color: #333333; }";
    gtk_css_provider_load_from_string(provider, drop_target_css);

    GtkStyleContext *context = gtk_widget_get_style_context(widgets->image);
    gtk_style_context_add_provider(context, GTK_STYLE_PROVIDER(provider), GTK_STYLE_PROVIDER_PRIORITY_USER);
    gtk_widget_set_name(widgets->image, "drop-target");

    widgets->grid = gtk_grid_new();
    gtk_box_append(GTK_BOX(vbox), widgets->grid);

    for (int i = 0; i < 10; i++)
    {
        widgets->checkboxes[i] = gtk_check_button_new_with_label(sizes[i * 2]);
        gtk_grid_attach(GTK_GRID(widgets->grid), widgets->checkboxes[i], i % 2, i / 2, 1, 1);
    }

    // TODO: Add a select all and deselect all button
    // TODO: Add a button to open the generated directory

    GtkWidget *button = gtk_button_new_with_label("Resize Images");
    g_signal_connect_swapped(button, "clicked", G_CALLBACK(resize_images), widgets);
    gtk_box_append(GTK_BOX(vbox), button);

    gtk_window_present(GTK_WINDOW(widgets->window));
}

int main(int argc, char **argv)
{
    GtkApplication *app = gtk_application_new("com.example.ImageResizer", G_APPLICATION_DEFAULT_FLAGS);
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);
    int status = g_application_run(G_APPLICATION(app), argc, argv);
    g_object_unref(app);
    return status;
}
