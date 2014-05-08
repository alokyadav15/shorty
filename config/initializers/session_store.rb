# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :active_record_store , {
	:key => "_shorty_session",
	:expire_after => 10.minutes
}