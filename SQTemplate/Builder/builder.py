import os, sys, json

def cur_file_dir():
   path = sys.path[0]
   if os.path.isdir(path):
        return path
   elif os.path.isfile(path):
        return os.path.dirname(path)

file_json = open(cur_file_dir() + "/config.json", "r")
data_json = json.loads(file_json.read())

root = str(data_json["super"])
controller = str(data_json["controller"])

presenter_h = ''
presenter_m = ''
for operation in data_json["presenter"]:
   presenter_h += '\n- (void)' + str(operation) + ';'
   presenter_m += '- (void)' + str(operation) + ' {\n\n}\n\n'

view_model_h = ''
view_model_m = ''
for request in data_json["viewModel"]:
   view_model_h += '- (void)' + str(request) + 'WithParameter:(NSDictionary *)parameter finishedCallBack:(void (^)())finishCallBack;\n'
   view_model_m += '\n- (void)' + str(request) + 'WithParameter:(NSDictionary *)parameter finishedCallBack:(void (^)())finishCallBack {\n\n}\n'

model = ''
for key in data_json["model"]:
   type = ''
   modified = ''
   value = data_json["model"][key]
   if value == 'String':
      type = 'NSString * ' 
      modified = 'copy'
   elif value == 'Int':
   	  type = 'NSInteger '
   	  modified = 'assign'
   elif value == 'Float':
   	  type = 'CGFloat '
   	  modified = 'assign'
   elif value == 'Bool':
   	  type = 'BOOL '
   	  modified = 'assign'
   elif value == 'Array':
   	  type = 'NSArray * '
   	  modified = 'strong'
   elif value == 'Dictionary':
   	  type = 'NSDictionary * '
   	  modified = 'strong'
   else:
   	  type = value
   	  modified = 'strong'
   model += '\n@property (nonatomic,' + modified + ') ' + type + str(key) + ';'

file_json.close()

os.path.join(cur_file_dir(), controller)
os.mkdir(cur_file_dir() + "/" + controller)

def builder(path, file):
   r = open(cur_file_dir() + '/Template/' + path, 'r')
   d = r.read()
   r.close()
   w = open(cur_file_dir() + '/' + controller + '/' + controller + file, 'w')
   w.write(d.replace('<#Unit#>', controller).replace('<#unit#>', controller.lower()).replace('<#Root#>', root).replace('<#ViewOperation#>', presenter_h).replace('<#ViewOperation_m#>', presenter_m).replace('<#ModelInterface#>', model).replace('<#ViewModelInterface#>', view_model_h).replace('<#ViewModelImplementation#>', view_model_m))
   w.close()

builder('InterfaceTemplate.h', 'Interface.h')
builder('ControllerTemplate.h', 'ViewController.h')
builder('ControllerTemplate.m', 'ViewController.m')
builder('ModelTemplate.h', 'Model.h')
builder('ModelTemplate.m', 'Model.m')
builder('PresenterTemplate.h', 'Presenter.h')
builder('PresenterTemplate.m', 'Presenter.m')
builder('ViewModelTemplate.h', 'ViewModel.h')
builder('ViewModelTemplate.m', 'ViewModel.m')
builder('ViewTemplate.h', 'View.h')
builder('ViewTemplate.m', 'View.m')






