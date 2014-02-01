updateCountdown = ->
  remaining = 140 - jQuery("#micropost_content").val().length
  jQuery(".countdown").text remaining + " characters left"

jQuery ->
  updateCountdown()
  $("#micropost_content").change updateCountdown
  $("#micropost_content").keyup updateCountdown