extends RichTextLabel

const TIME_PERIOD = .015
var time = 0

#func _ready():
#    var credits_text = load("res://Resources/credits.txt")
#    var file = File.new()
#
#    if file.open(credits_text, File.READ) == OK:
#        var text = file.get_as_text()
#        set_bbcode(text)
#        file.close()

func _process(delta):
    time += delta
    if time > TIME_PERIOD:
        get_child(0).value += 1
        time = 0
