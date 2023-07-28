extends MultiplayerLevel

var start_time
var game_ended = false

func _process(delta):
	if start_time && not game_ended:
		var time_now = Time.get_ticks_msec()
		var time_elapsed = time_now - start_time
		$WinScreen.text = _format_seconds(time_elapsed / 1000, false)

func _on_start_pressed():
	if multiplayer.is_server() && not $StartWall.stopped && $StartWall && is_instance_valid($StartWall):
		$StartWall.remove()
		start_time = Time.get_ticks_msec()

func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func _on_finish_body_entered(body):
	if body.is_in_group("Players"):
		end_game()

func end_game():
	game_ended = true
