// Example of proper memory management in C GTK
#include <gtk/gtk.h>

typedef struct {
    GtkWidget *window;
    GtkWidget *text_view;
    GtkTextBuffer *buffer;
    char *current_file;
} AppData;

static void
cleanup_app_data(AppData *data)
{
    // Free allocated memory
    if (data->current_file) {
        g_free(data->current_file);
        data->current_file = NULL;
    }

    // Disconnect signals if needed
    // GTK automatically handles widget cleanup
}

static void
on_window_destroy(GtkWidget *widget, AppData *data)
{
    cleanup_app_data(data);
    gtk_main_quit();
}

static void
load_file(const char *filename, AppData *data)
{
    GError *error = NULL;
    char *content = NULL;
    gsize length;

    // Read file with proper error handling
    if (g_file_get_contents(filename, &content, &length, &error)) {
        gtk_text_buffer_set_text(data->buffer, content, length);

        // Update current file
        g_free(data->current_file);
        data->current_file = g_strdup(filename);

        // Update window title
        char *basename = g_path_get_basename(filename);
        gtk_window_set_title(GTK_WINDOW(data->window), basename);
        g_free(basename);
    } else {
        // Show error dialog
        GtkWidget *dialog = gtk_message_dialog_new(
            GTK_WINDOW(data->window),
            GTK_DIALOG_MODAL,
            GTK_MESSAGE_ERROR,
            GTK_BUTTONS_OK,
            "Failed to load file: %s",
            error->message
        );
        gtk_dialog_run(GTK_DIALOG(dialog));
        gtk_widget_destroy(dialog);
        g_error_free(error);
    }

    // Free content (always free even if NULL)
    g_free(content);
}