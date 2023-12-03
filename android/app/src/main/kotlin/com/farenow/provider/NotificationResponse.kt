package com.farenow.provider

import com.google.gson.annotations.SerializedName

data class NotificationResponse(

        @field:SerializedName("user_id")
        val userId: String? = null,

        @field:SerializedName("type")
        val type: String? = null,

        @field:SerializedName("service_request_id")
        val serviceRequestId: String? = null,

        @field:SerializedName("title")
        val title: String? = null,

        @field:SerializedName("body")
        val body: String? = null,

        @field:SerializedName("receiver_id")
        val receiverId: String? = null,

        @field:SerializedName("sender_id")
        val senderId: String? = null,

        @field:SerializedName("show")
        var show: Boolean = false
)