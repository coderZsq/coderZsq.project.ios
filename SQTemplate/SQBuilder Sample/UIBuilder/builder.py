import os, sys, json

def cur_file_dir():
   path = sys.path[0]
   if os.path.isdir(path):
        return path
   elif os.path.isfile(path):
        return os.path.dirname(path)

file_json = open(cur_file_dir() + "/config.json", "r")
data_json = json.loads(file_json.read())

bean = str(data_json["bean"])
unit = str(data_json["unit"])
isImport = str(data_json["isImport"])

submodel = data_json["submodel"]
subview = data_json["subview"]
tableViewCell = data_json["tableViewCell"]
collectionViewCell = data_json["collectionViewCell"]

viewProperty = ''
viewLazyLoad = ''
viewSetup = ''
viewLayout = ''
viewImport = ''
classImport = ''
for key in data_json["layout"]:
   value = data_json["layout"][key]
   viewProperty += "@property (nonatomic,strong) " + str(value) + " * " + str(key) + ";\n"
   viewLazyLoad += "- (" + str(value) + " *)" + str(key) + " {\n\n    if (!_" + str(key) + ") {\n        _" + str(key) + " = [" + str(value) + " new];\n    }\n    return _" + str(key) + ";\n}\n\n"
   viewSetup += "\n    [self addSubview:self." + str(key) + "];"
   viewLayout += "    CGFloat " + str(key) + "X = <#length#>;\n    CGFloat " + str(key) + "Y = <#length#>;\n    CGFloat " + str(key) + "W = <#length#>;\n    CGFloat " + str(key) + "H = <#length#>;\n    _" + str(key) + ".frame = CGRectMake(" + str(key) + "X, " + str(key) + "Y, " + str(key) + "W, " + str(key) + "H);\n\n"
   if isImport == 'Yes':
      viewImport += '#import "' + str(value) + '.h"\n'
      classImport += '@class ' + str(value) + ';\n'

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

def builder(path, file, isbean):
   r = open(cur_file_dir() + '/UITemplate/' + path, 'r')
   d = r.read()
   r.close()
   if isbean == 'Yes':
      w = open(cur_file_dir() + '/' + bean + file, 'w')
   else:
      w = open(cur_file_dir() + '/' + unit + file, 'w')
   w.write(d.replace("<#ViewProperty#>", viewProperty).replace("<#Unit#>", unit).replace("<#ViewLazyLoad#>", viewLazyLoad).replace("<#ViewSetup#>",viewSetup).replace("<#ViewLayout#>",viewLayout).replace("<#SubUnit#>", bean).replace("<#ViewImport#>", viewImport).replace("<#ModelInterface#>", model).replace("<#ClassImport#>", classImport))
   w.close()

if subview == "Yes":
   builder("SubviewTemplate.h", "View.h", "No")
   builder("SubviewTemplate.m", "View.m", "No")

if tableViewCell == "Yes":
   builder("TableViewCellTemplate.h", "Cell.h", "No")
   builder("TableViewCellTemplate.m", "Cell.m", "No")
   builder("CellAdapterTemplate.h", "CellAdapter.h", "No")

if submodel == 'Yes':
   builder("SubmodelTemplate.h", "Model.h", "Yes")
   builder("SubmodelTemplate.m", "Model.m", "Yes")

if collectionViewCell == 'Yes':
   builder("CollectionViewTemplate.h", "View.h", "No")
   builder("CollectionViewTemplate.m", "View.m", "No")
   builder("CollectionViewCellTemplate.h", "Cell.h", "No")
   builder("CollectionViewCellTemplate.m", "Cell.m", "No")
   builder("CellAdapterTemplate.h", "CellAdapter.h", "No")



