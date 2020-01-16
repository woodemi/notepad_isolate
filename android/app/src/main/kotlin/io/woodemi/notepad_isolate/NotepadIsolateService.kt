package io.woodemi.notepad_isolate

import android.app.Service
import android.content.Intent
import android.os.IBinder

class NotepadIsolateService : Service() {
    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

}
