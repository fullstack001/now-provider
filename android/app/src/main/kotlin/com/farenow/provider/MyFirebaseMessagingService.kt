package  com.farenow.provider;

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.graphics.Color
import android.media.AudioAttributes
import android.media.RingtoneManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson


class MyFirebaseMessagingService : FirebaseMessagingService() {
    private val SIT_REQUEST_NOTIFICATION_CHANNEL = "2"
    var SIT_REQUEST_NOTIFICATION = 123
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        Log.d(
            "Application.APPTAG",
            "myFirebaseMessagingService - onMessageReceived - message: $remoteMessage"
        )
        sendSitRequestAlarm(remoteMessage.toIntent().getExtras(), remoteMessage.data)
    }

    @SuppressLint("UnspecifiedImmutableFlag")
    private fun sendSitRequestAlarm(extras: Bundle?, data: MutableMap<String, String>) {
        createNotificationChannelWithSound()

        Log.d("pay Load: ", "$data")


        var title: String? = null
        var content: String? = null
        var userId: String? = null
        var serviceId: String? = null

        var notificationResponse: NotificationResponse? = null

        if (data["type"].toString().toLowerCase() == "message") {
            title = data["title"]
            content = data["body"]
            userId = data["user_id"]
            serviceId = data["service_request_id"]

            notificationResponse = NotificationResponse(
                title = title, body = content, userId = userId, serviceRequestId = serviceId, type = data["type"]
            )
        } else {
            title = data["title"]
            content = data["body"]
            userId = data["user_id"]
            serviceId = data["service_request_id"]

            notificationResponse = NotificationResponse(
                title = title, body = content, receiverId = data["receiver_id"],
                senderId = data["sender_id"],
                userId = userId,
                serviceRequestId = serviceId,
                type = data["type"]
            )
        }

        if (!MOBILE_ON) {
            notificationResponse.show = false
            val intent = Intent(this, MainActivity::class.java)
            var dataObj: String = Gson().toJson(notificationResponse)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.putExtras(extras!!)
            intent.putExtra("msg", dataObj)
            val pendingIntent: PendingIntent =
                PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE)
            val builder: NotificationCompat.Builder =
                NotificationCompat.Builder(this, SIT_REQUEST_NOTIFICATION_CHANNEL)
                    .setSmallIcon(R.drawable.ic_app_launcher)
                    .setContentTitle(title)
                    .setContentText(content)
                    .setLights(Color.YELLOW, 100, 100)
                    .setPriority(NotificationCompat.PRIORITY_MAX)
                    .setContentIntent(pendingIntent)
                    .setTimeoutAfter(32000)
                    .setAutoCancel(false)
            val notificationManager = NotificationManagerCompat.from(this)
            val notification: Notification = builder.build()
//            notification.flags = notification.flags or Notification.FLAG_INSISTENT
            notificationManager.notify(SIT_REQUEST_NOTIFICATION, notification)
            startActivity(intent)
        } else {
            notificationResponse.show = true
            var dataObj: String = Gson().toJson(notificationResponse)
            print(dataObj)
            sendDataToActivity(dataObj)
        }
    }

    private fun sendDataToActivity(data: String) {
        val sendLevel = Intent()
        sendLevel.action = "GET_SIGNAL_STRENGTH"
        sendLevel.putExtra("LEVEL_DATA", data)
        sendBroadcast(sendLevel)
    }

    private fun createNotificationChannelWithSound() {
        val sound = RingtoneManager.getActualDefaultRingtoneUri(
            applicationContext,
            RingtoneManager.TYPE_NOTIFICATION
        )
        val attributes = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_NOTIFICATION)
            .build()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name: CharSequence = "notifications_channel"
            val description = "Webflora notification channel"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(SIT_REQUEST_NOTIFICATION_CHANNEL, name, importance)
            channel.description = description
            channel.enableVibration(true)
            channel.enableLights(true)
            channel.lightColor = Color.YELLOW
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}

// from provider to user
/*
{"body":"Provider nouman REJECTED your service request","provider_id":"246","title":"Request REJECTED","type":"SERVICE_REQUEST"}
{"body":"Provider nouman ACCEPTED your service request","provider_id":"246","title":"Request ACCEPTED","type":"SERVICE_REQUEST"}
{"body":"nouman working on your Service Request just started now","provider_id":"246","serviceRequestId":"560","title":"Start working on your Service Request","type":"SERVICE_REQUEST"}
{"body":"nouman end working on your Service Request just now","provider_id":"246","serviceRequestId":"560","title":"End working on your Service Request","type":"SERVICE_REQUEST","workedHours":"0"}
 */