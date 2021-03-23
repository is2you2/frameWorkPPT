extends Node

# 데이터가 정리되는 곳
var data_path:=OS.get_executable_path().get_base_dir()+'/frameworkPPT_data'

func _ready():
	get_tree().connect("files_dropped",self,'_files_dropped')
	

# 파일 내려놓기 동작
func _files_dropped(files:PoolStringArray,screen:int):
	for target in files:
		var dir:=Directory.new()
		if dir.open(target) == OK: # 폴더임
			dir.list_dir_begin(true)
			while true: # 폴더 내부 전부 검토
				var file:=dir.get_next()
				if not file:
					break
				else:
					print_debug(file,' ~is dir?: ',dir.current_is_dir())
		else: # 파일임
			print_debug('파일임: ',target)
			printerr('파일/폴더 올려놓기 오류')

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _exit_tree():
	get_tree().disconnect("files_dropped",self,'_files_dropped')
