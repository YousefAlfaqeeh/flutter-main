package com.example.udemy_flutter

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import android.app.NotificationChannel
import android.app.NotificationManager
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        createNotificationChannel()
    }
//
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "custom_channel_id"
            val channelName = "Custom Notifications"
            val soundUri = Uri.parse("android.resource://${packageName}/raw/new_beeb")

            val channel = NotificationChannel(
                channelId,
                channelName,
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.setSound(soundUri, null)

            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }
    }
//    private val CHANNEL = "nl.sobit" // replace with your own unique channel name which you set in the dart file as platform
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            // Note: this method is invoked on the main thread.
//                call, result ->
////            if (call.method == "createChannel") {
////
////                    val groupId: String? = call.argument("groupId") // the id of the group you want the channel to be created
////                    val id: String? = call.argument("id") // the id of the channel
////                    val name: String? = call.argument("name") // the name of the channel to be seen by the user within the notification settings
////                    val description: String? = call.argument("description") // optional description to go along with the name
////                    val soundName: String? = call.argument("sound") // reference to the file name you want to attach to the channel
////                    deleteChannel(id) // we do this to delete the former settings in order to change the sound if needed, if there's no channel by this id, nothing will happen
////
////                    val sound = getSound(soundName) // get the corresponding sound Uri, see further on in the getSound method
////                    val audioAttributes = AudioAttributes.Builder() // declare the AudioAttributes
////                        .setUsage(AudioAttributes.USAGE_NOTIFICATION)
////                        .build()
////
////                    val mChannel = NotificationChannel(id, name,
////                        NotificationManager.IMPORTANCE_DEFAULT) // create the actual channel
////                    mChannel.setDescription(description) // add the description if set
////                    mChannel.setSound(sound, audioAttributes) // add the sound for this channel
////                    mChannel.setGroup(groupId) // set the group for this channel, make sure the group is created in an earlier call
////
////                    val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
////                    notificationManager.createNotificationChannel(mChannel) // attach the channel to the notificationManager
////
////                    result.success("Notification channel $name with sound $soundName created") // result is given back to the flutter call
////
////            } else if(call.method == "deleteChannel") {
////                val id: String? = call.argument("id") // get the id of the channel to be deleted
////                deleteChannel(id) // call the method to delete the channel
////                result.success("Channel with id $id deleted")
////            } else if(call.method == "deleteChannelGroup") {
////                val groupId: String? = call.argument("groupId") // id of the channelgroup to be deleted, if there are channels within this group, they will be deleted as well
////                deleteGroup(groupId) // call the method to delete the channelgroup
////                result.success("Group with id $groupId deleted")
////            } else if(call.method == "createChannelGroup") {
////                val groupId: String? = call.argument("groupId") // id of the channelgroup you want to create
////                val groupName: String? = call.argument("groupName") // name for the channelgroup to be seen within the notification settings
////               // createGroup(groupId,groupName) // call the method to create the channelgroup
////                result.success("Group with name $groupName created") // return result
////            } else {
////                result.notImplemented()
////            }
////        }
////    }
//            if (call.method == "createNotificationChannel"){
//                val argData = call.arguments as java.util.HashMap<String, String>
//                val completed = createNotificationChannel(argData)
//                if (completed == true){
//                    result.success(completed)
//                }
//                else{
//                    result.error("Error Code", "Error Message", null)
//                }
//            } else {
//                result.notImplemented()
//            }
//        }
//
//    }
//
//
//    private fun deleteGroup(groupId: String?) { // delete a channelgroup
//        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
//        notificationManager.deleteNotificationChannelGroup(groupId)
//    }
//
//    private fun deleteChannel(id : String?){ // delete a channel
//        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
//        notificationManager.deleteNotificationChannel(id)
//    }
//
//    private fun getSound(soundName: String?) :Uri { // get the sound Uri
//        return when (soundName) {
//            "concise" -> Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.alert) // the concise file sound
//            "light" -> Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.alert) // the light file sound
//            "plucky" -> Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.alert) // the pluck file sound
//            "tasty" -> Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.alert) // the tasty file sound
//
//            else -> Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.alert) // if the when statement couldn't find the corresponding item this one will be returned
//        }
//    }
//    private fun createNotificationChannel(mapData: HashMap<String,String>): Boolean {
//        val completed: Boolean
//        // Create the NotificationChannel
//        val id = mapData["id"]
//        val name = mapData["name"]
//        val descriptionText = mapData["description"]
//        val sound = "new_beeb"
//        val importance = NotificationManager.IMPORTANCE_HIGH
//        val mChannel = NotificationChannel(id, name, importance)
//        mChannel.description = descriptionText
//
//        val soundUri = Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://"+ getApplicationContext().getPackageName() + "/raw/new_beeb");
//        val att = AudioAttributes.Builder()
//            .setUsage(AudioAttributes.USAGE_NOTIFICATION)
//            .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
//            .build();
//
//        mChannel.setSound(soundUri, att)
//        // Register the channel with the system; you can't change the importance
//        // or other notification behaviors after this
//        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
//        notificationManager.createNotificationChannel(mChannel)
//        completed = true
//        return completed
//    }
}