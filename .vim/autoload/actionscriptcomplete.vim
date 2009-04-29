" Omni Completion for ActionScript 3
" Maintainer: Phil Peron (pperon AT gmail DOT com)
" Version: 0.1
" Last Update: July 20, 2007
"
" For more information on completion scripts, read the documentation at:
" 	http://vimdoc.sourceforge.net/htmldoc/insert.html#complete-functions
"
function! actionscriptcomplete#Complete(findstart, base)
	if a:findstart == 1 " locate the start of the replacement text
		let insertCol = col('.') - 1 
		let line = getline('.')

		while insertCol >= 0
			let c = line[insertCol - 1]
			if c =~ '\w'
				let insertCol -= 1
			else 
				let s:context = line[0:insertCol - 1]
				break	
			endif
		endwhile
		
		return insertCol
	else " return list of matches available
		let s:base = a:base
		return s:findMatches()
	endif
endfunction

function! s:findMatches()
	let matches = []

	if s:context =~ '\.'
		let matches = s:searchDotContext()
	elseif s:context =~ '\:'
		let matches = ['colon', 'context', 'items']
	else
		let matches = ['default', 'context', 'items']
	endif

	return matches
endfunction

function! s:searchDotContext()
	" if context contains a package followed by a dot, do a search on that 
	" package
	
	" TODO Deal with static methods on Final classes.
	
	" trim trailing dot 
	let package = strpart(s:context, 0, len(s:context) - 1)
	let mark = match(s:context, '[\.{0,},a-z,A-Z,_,$]\+\.$')
	let package = 's:' . strpart(package, mark)

	if(exists(package))
		return s:searchPackage(eval(package))
	else
		let udo = strpart(package, 2)
		return s:searchUserDefinedVars(udo)
	endif
endfunction

function! s:searchPackage(package)
	let matches = []

	" always add Object members
	call extend(a:package, s:topLevelClasses.Object)

	" now add inheritance
	let package = s:getInheritance(a:package)

	" check if we need to filter the results using partial (s:base) string
	if strlen(s:base) > 0
		let filter = 1
	else
		let filter = 0
	endif

	for entry in sort(items(package))
		" skip __inheritance__ key...
		if entry[0] == '__inheritance__'
			continue
		endif

		if filter
			if entry[0] =~ '^'. s:base
				call add(matches, entry[1].__menuItem__)
			endif
		else
			if entry[0] != '__menuItem__'
				call add(matches, entry[1].__menuItem__)
			endif
		endif
	endfor

	return matches
endfunction

function! s:getInheritance(obj)
	if has_key(a:obj, '__inheritance__')
		let i = s:getInheritance(eval('s:' . a:obj['__inheritance__']))
		call extend(a:obj, i)
		return a:obj
	else
		return a:obj
	endif
endfunction

function! s:searchUserDefinedVars(udo)
	let matches = []
	let udo = a:udo

	" set up our search arguments
	let pattern = 'var ' . udo . ':'
	let flags = 'bn'

	" grab the line that contains the object definition
	let lineNum = search(pattern, flags) 
	let line = getline(lineNum)

	" now boil it down to the object type
	"
	" filtering out everything before...
	let pattern = pattern . '[a-z,A-Z]'
	let mark = matchend(line, pattern) - 1 
	let objType = strpart(line, mark)
	" ...and everything after
	let mark = matchend(objType, '[^a-z,A-Z,\.{0,}]') - 1
	let objType = strpart(objType, 0, mark)

	" was the var declared using the absolute name of the data type?
	if match(objType, '[a-z]\+\.[a-z]\+\.[a-z,A-Z]\+') == -1
		let objType = s:getFullyQualifiedName(objType)
	else
		let objType = 's:' . objType
	endif

	if len(objType) > 0
		let matches = s:searchPackage(eval(objType))
	else
		let matches = [objType, 'is', 'user-defined?']
	endif 

	return matches
endfunction

function! s:getFullyQualifiedName(name)
	let fqn = ''
	" first search top level classes
	if has_key(s:topLevelClasses, a:name)
		let fqn = 's:topLevelClasses.' . a:name
		return fqn
	endif

	" search the other namespaces for a:name
	let found = 0

	for package in items(s:namespaces)
		for subpackage in items(package[1])
			if has_key(subpackage[1], a:name)
				let fqn = subpackage[0] . '.' . a:name
				let found = 1
				break
			endif
		endfor
		
		if found
			let fqn = package[0] . '.' . fqn
			break
		endif
	endfor

	return fqn
endfunction

" TODO finish...
"
" Top Level Classes and members
" flash package class members
" entire mx, adobe, and air packages

" Top Level classes
let s:topLevelClasses = {
\	'Array': {
\		'__menuItem__': {
\			'word': 'Array'
\		},
\		'length': {
\			'__menuItem__': {
\				'word': 'length'
\			}
\		}
\	},
\	'Boolean': {
\		'__menuItem__': {
\			'word': 'Boolean'
\		}
\	},
\	'Object': {
\		'__menuItem__': {
\			'word': 'Object'
\		},
\		'constructor': {
\			'__menuItem__': {
\				'word': 'constructor'
\			}
\		},
\		'prototype': {
\			'__menuItem__': {
\				'word': 'prototype'
\			}
\		},
\		'hasOwnProperty': {
\			'__menuItem__': {
\				'word': 'hasOwnProperty'
\			}
\		},
\		'isPrototypeOf': {
\			'__menuItem__': {
\				'word': 'isPrototypeOf'
\			}
\		},
\		'propertyIsEnumerable': {
\			'__menuItem__': {
\				'word': 'propertyIsEnumerable'
\			}
\		},
\		'setPropertyIsEnumerable': {
\			'__menuItem__': {
\				'word': 'setPropertyIsEnumerable'
\			}
\		},
\		'toString': {
\			'__menuItem__': {
\				'word': 'toString'
\			}
\		},
\		'valueOf': {
\			'__menuItem__': {
\				'word': 'valueOf'
\			}
\		}
\	}
\}

" flash package definition
let s:flash = {
\ 	'accessibility': {
\		'__menuItem__': {
\			'word': 'accessibility'
\		},
\ 		'Accessibility': {
\			'__menuItem__': {
\				'word': 'Accessibility'
\			},
\			'active': {
\				'__menuItem__': {
\					'word': 'active',
\					'menu': '[STATIC]'
\				}
\			},
\			'updateProperties': {
\				'__menuItem__': {
\					'word': 'updateProperties',
\					'menu': '[STATIC]'
\				}
\			}
\		},
\ 		'AccessibilityProperties': {
\			'__menuItem__': {
\				'word': 'AccessibilityProperties'
\			},
\			'description': {
\				'__menuItem__': {
\					'word': 'description'
\				}
\			},
\			'forceSimple': {
\				'__menuItem__': {
\					'word': 'forceSimple'
\				}
\			},
\			'name': {
\				'__menuItem__': {
\					'word': 'name'
\				}
\			},
\			'noAutoLabeling': {
\				'__menuItem__': {
\					'word': 'noAutoLabeling'
\				}
\			}, 
\ 			'shortcut': {
\				'__menuItem__': {
\					'word': 'shortcut'
\				}
\			},
\			'silent': {
\				'__menuItem__': {
\					'word': 'silent'
\				}
\			}
\		}
\ 	},
\	'data': {
\		'__menuItem__': {
\			'word': 'data'
\		},
\		'SQLColumnNameStyle': {
\			'__menuItem__': {
\				'word': 'SQLColumnNameStyle'
\			}
\		},
\		'SQLConnection': {
\			'__menuItem__': {
\				'word': 'SQLConnection'
\			}
\		},
\		'SQLResult': {
\			'__menuItem__': {
\				'word': 'SQLResult'
\			}
\		},
\		'SQLStatement': {
\			'__menuItem__': {
\				'word': 'SQLStatement'
\			}
\		},
\		'SQLTransactionLockType': {
\			'__menuItem__': {
\				'word': 'SQLTransactionLockType'
\			}
\		}
\	},
\	'desktop': {
\		'__menuItem__': {
\			'word': 'desktop'
\		},
\		'ClipboardManager': {
\			'__menuItem__': {
\				'word': 'ClipboardManager'
\			}
\		},
\		'DragActions': {
\			'__menuItem__': {
\				'word': 'DragActions'
\			}
\		},
\		'DragManager': {
\			'__menuItem__': {
\				'word': 'DragManager'
\			}
\		},
\		'DragOptions': {
\			'__menuItem__': {
\				'word': 'DragOptions'
\			}
\		},
\		'Icon': {
\			'__menuItem__': {
\				'word': 'Icon'
\			}
\		},
\		'TransferableData': {
\			'__menuItem__': {
\				'word': 'TransferableData'
\			}
\		},
\		'TransferableFormats': {
\			'__menuItem__': {
\				'word': 'TransferableFormats'
\			}
\		},
\		'TransferableTransferMode': {
\			'__menuItem__': {
\				'word': 'TransferableTransferMode'
\			}
\		},
\	},
\	'display': {
\		'__menuItem__': {
\			'word': 'display'
\		},
\		'IBitmapDrawable': {
\			'__menuItem__': { 
\				'word': 'IBitmapDrawable'
\			}
\		},
\		'ActionScriptVersion': {
\			'__menuItem__': { 
\				'word': 'ActionScriptVersion'
\			}
\		},
\		'AVM1Movie': {
\			'__menuItem__': { 
\				'word': 'AVM1Movie'
\			}
\		},
\		'Bitmap': {
\			'__menuItem__': { 
\				'word': 'Bitmap'
\			}
\		},
\		'BitmapData': {
\			'__menuItem__': { 
\				'word': 'BitmapData'
\			}
\		},
\		'BitmapDataChannel': {
\			'__menuItem__': {
\				'word': 'BitmapDataChannel'
\			}
\		},
\		'BlendMode': {
\			'__menuItem__': { 
\				'word': 'BlendMode'
\			}
\		},
\		'CapsStyle': {
\			'__menuItem__': { 
\				'word': 'CapsStyle'
\			}
\		},
\		'DisplayObject': {
\			'__inheritance__': 'flash.events.EventDispatcher',
\			'__menuItem__': { 
\				'word': 'DisplayObject'
\			},
\			'accessibilityProperties': {
\				'__menuItem__': {
\					'word': 'accessibilityProperties'
\				}
\			}
\		},
\		'DisplayObjectContainer': {
\			'__menuItem__': { 
\				'word': 'DisplayObjectContainer'
\			}
\		},
\		'FrameLabel': {
\			'__menuItem__': {
\				'word': 'FrameLabel'
\			}
\		},
\		'GradientType': {
\			'__menuItem__': {
\				'word': 'GradientType'
\			}
\		},
\		'Graphics': {
\			'__menuItem__': {
\				'word': 'Graphics'
\			}
\		},
\		'InteractiveObject': {
\			'__inheritance__': 'flash.display.DisplayObject',
\			'__menuItem__': {
\				'word': 'InteractiveObject'
\			},
\			'contextMenu': {
\				'__menuItem__': {
\					'word': 'contextMenu'
\				}
\			}
\		},
\		'InterpolationMethod': {
\			'__menuItem__': {
\				'word': 'InterpolationMethod'
\			}
\		},
\		'JointStyle': {
\			'__menuItem__': {
\				'word': 'JointStyle'
\			}
\		},
\		'LineScaleMode': {
\			'__menuItem__': {
\				'word': 'LineScaleMode'
\			}
\		},
\		'Loader': {
\			'__menuItem__': {
\				'word': 'Loader'
\			}
\		},
\		'LoaderInfo': {
\			'__menuItem__': {
\				'word': 'LoaderInfo'
\			}
\		},
\		'MorphShape': {
\			'__menuItem__': {
\				'word': 'MorphShape'
\			}
\		},
\		'MovieClip': {
\			'__menuItem__': {
\				'word': 'MovieClip'
\			}
\		},
\		'NativeMenu': {
\			'__menuItem__': {
\				'word': 'NativeMenu'
\			}
\		},
\		'NativeMenuItem': {
\			'__menuItem__': {
\				'word': 'NativeMenuItem'
\			}
\		},
\		'NativeWindow': {
\			'__menuItem__': {
\				'word': 'NativeWindow'
\			}
\		},
\		'NativeWindowDisplayState': {
\			'__menuItem__': {
\				'word': 'NativeWindowDisplayState'
\			}
\		},
\		'NativeWindowInitOptions': {
\			'__menuItem__': {
\				'word': 'NativeWindowInitOptions'
\			}
\		},
\		'NativeWindowResize': {
\			'__menuItem__': {
\				'word': 'NativeWindowResize'
\			}
\		},
\		'NativeWindowSystemChrome': {
\			'__menuItem__': {
\				'word': 'NativeWindowSystemChrome'
\			}
\		},
\		'NativeWindowType': {
\			'__menuItem__': {
\				'word': 'NativeWindowType'
\			}
\		},
\		'PixelSnapping': {
\			'__menuItem__': {
\				'word': 'PixelSnapping'
\			}
\		},
\		'Scene': {
\			'__menuItem__': {
\				'word': 'Scene'
\			}
\		},
\		'Shape': {
\			'__menuItem__': {
\				'word': 'Shape'
\			}
\		},
\		'SimpleButton': {
\			'__menuItem__': {
\				'word': 'SimpleButton'
\			}
\		},
\		'SpreadMethod': {
\			'__menuItem__': {
\				'word': 'SpreadMethod'
\			}
\		},
\		'Sprite': {
\			'__menuItem__': {
\				'word': 'Sprite'
\			}
\		},
\		'Stage': {
\			'__menuItem__': {
\				'word': 'Stage'
\			}
\		},
\		'StageAlign': {
\			'__menuItem__': {
\				'word': 'StageAlign'
\			}
\		},
\		'StageQuality': {
\			'__menuItem__': {
\				'word': 'StageQuality'
\			}
\		},
\		'StageScaleMode': {
\			'__menuItem__': {
\				'word': 'StageScaleMode'
\			}
\		},
\		'SWFVersion': {
\			'__menuItem__': {
\				'word': 'SWFVersion'
\			}
\		}
\	},
\	'errors': {
\		'__menuItem__': {
\			'word': 'errors'
\		},
\		'EOFError': {
\			'__menuItem__': {
\				'word': 'EOFError'
\			}
\		},
\		'IllegalOperationError': {
\			'__menuItem__': {
\				'word': 'IllegalOperationError'
\			}
\		},
\		'InvalidSWFError': {
\			'__menuItem__': {
\				'word': 'InvalidSWFError'
\			}
\		},
\		'IOError': {
\			'__menuItem__': {
\				'word': 'IOError'
\			}
\		},
\		'MemoryError': {
\			'__menuItem__': {
\				'word': 'MemoryError'
\			}
\		},
\		'ScriptTimeoutError': {
\			'__menuItem__': {
\				'word': 'ScriptTimeoutError'
\			}
\		},
\		'SQLError': {
\			'__menuItem__': {
\				'word': 'SQLError'
\			}
\		},
\		'SQLErrorCode': {
\			'__menuItem__': {
\				'word': 'SQLErrorCode'
\			}
\		},
\		'SQLErrorOperation': {
\			'__menuItem__': {
\				'word': 'SQLErrorOperation'
\			}
\		},
\		'StackOverflowError': {
\			'__menuItem__': {
\				'word': 'StackOverflowError'
\			}
\		}
\	},
\	'events': {
\		'__menuItem__': {
\			'word': 'events'
\		},
\		'IEventDispatcher': {
\			'__menuItem__': {
\				'word': 'IEventDispatcher'
\			}
\		},
\		'ActivityEvent': {
\			'__menuItem__': {
\				'word': 'ActivityEvent'
\			}
\		},
\		'AsyncErrorEvent': {
\			'__menuItem__': {
\				'word': 'AsyncErrorEvent'
\			}
\		},
\		'ContextMenuEvent': {
\			'__menuItem__': {
\				'word': 'ContextMenuEvent'
\			}
\		},
\		'DataEvent': {
\			'__menuItem__': {
\				'word': 'DataEvent'
\			}
\		},
\		'ErrorEvent': {
\			'__menuItem__': {
\				'word': 'ErrorEvent'
\			}
\		},
\		'Event': {
\			'__menuItem__': {
\				'word': 'Event'
\			}
\		},
\		'EventDispatcher': {
\			'__menuItem__': {
\				'word': 'EventDispatcher'
\			},
\			'addEventListener': {
\				'__menuItem__': {
\					'word': 'addEventListener'
\				}
\			},
\			'dispatchEvent': {
\				'__menuItem__': {
\					'word': 'dispatchEvent'
\				}
\			},
\			'hasEventListener': {
\				'__menuItem__': {
\					'word': 'hasEventListener'
\				}
\			},
\			'removeEventListener': {
\				'__menuItem__': {
\					'word': 'removeEventListener'
\				}
\			},
\			'willTrigger': {
\				'__menuItem__': {
\					'word': 'willTrigger'
\				}
\			}
\		},
\		'EventPhase': {
\			'__menuItem__': {
\				'word': 'EventPhase'
\			}
\		},
\		'FileListEvent': {
\			'__menuItem__': {
\				'word': 'FileListEvent'
\			}
\		},
\		'FocusEvent': {
\			'__menuItem__': {
\				'word': 'FocusEvent'
\			}
\		},
\		'HTMLUncaughtJavaScriptExceptionEvent': {
\			'__menuItem__': {
\				'word': 'HTMLUncaughtJavaScriptExceptionEvent'
\			}
\		},
\		'HTTPStatusEvent': {
\			'__menuItem__': {
\				'word': 'HTTPStatusEvent'
\			}
\		},
\		'IMEEvent': {
\			'__menuItem__': {
\				'word': 'IMEEvent'
\			}
\		},
\		'InvokeEvent': {
\			'__menuItem__': {
\				'word': 'InvokeEvent'
\			}
\		},
\		'IOErrorEvent': {
\			'__menuItem__': {
\				'word': 'IOErrorEvent'
\			}
\		},
\		'KeyboardEvent': {
\			'__menuItem__': {
\				'word': 'KeyboardEvent'
\			}
\		},
\		'MouseEvent': {
\			'__menuItem__': {
\				'word': 'MouseEvent'
\			}
\		},
\		'NativeDragEvent': {
\			'__menuItem__': {
\				'word': 'NativeDragEvent'
\			}
\		},
\		'NativeWindowBoundsEvent': {
\			'__menuItem__': {
\				'word': 'NativeWindowBoundsEvent'
\			}
\		},
\		'NativeWindowDisplayStateEvent': {
\			'__menuItem__': {
\				'word': 'NativeWindowDisplayStateEvent'
\			}
\		},
\		'NativeWindowErrorEvent': {
\			'__menuItem__': {
\				'word': 'NativeWindowErrorEvent'
\			}
\		},
\		'NetStatusEvent': {
\			'__menuItem__': {
\				'word': 'NetStatusEvent'
\			}
\		},
\		'OutputProgressEvent': {
\			'__menuItem__': {
\				'word': 'OutputProgressEvent'
\			}
\		},
\		'ProgressEvent': {
\			'__menuItem__': {
\				'word': 'ProgressEvent'
\			}
\		},
\		'SecurityErrorEvent': {
\			'__menuItem__': {
\				'word': 'SecurityErrorEvent'
\			}
\		},
\		'SQLErrorEvent': {
\			'__menuItem__': {
\				'word': 'SQLErrorEvent'
\			}
\		},
\		'SQLEvent': {
\			'__menuItem__': {
\				'word': 'SQLEvent'
\			}
\		},
\		'SQLUpdateEvent': {
\			'__menuItem__': {
\				'word': 'SQLUpdateEvent'
\			}
\		},
\		'StatusEvent': {
\			'__menuItem__': {
\				'word': 'StatusEvent'
\			}
\		},
\		'SyncEvent': {
\			'__menuItem__': {
\				'word': 'SyncEvent'
\			}
\		},
\		'TextEvent': {
\			'__menuItem__': {
\				'word': 'TextEvent'
\			}
\		},
\		'TimerEvent': {
\			'__menuItem__': {
\				'word': 'TimerEvent'
\			}
\		}
\	},
\	'external': {
\		'__menuItem__': {
\			'word': 'external'
\		}, 
\		'ExternalInterface': {
\			'__menuItem__': {
\				'word': 'ExternalInterface'
\			}
\		}
\	},
\	'filesystem': {
\		'__menuItem__': {
\			'word': 'filesystem'
\		}, 
\		'File': {
\			'__menuItem__': {
\				'word': 'File'
\			}
\		},
\		'FileMode': {
\			'__menuItem__': {
\				'word': 'FileMode'
\			}
\		},
\		'FileStream': {
\			'__menuItem__': {
\				'word': 'FileStream'
\			}
\		}
\	},
\	'filters': {
\		'__menuItem__': { 
\			'word': 'filters'
\		},
\		'BevelFilter': {
\			'__menuItem__': {
\				'word': 'BevelFilter'
\			}
\		},
\		'BitmapFilter': {
\			'__menuItem__': {
\				'word': 'BitmapFilter'
\			}
\		},
\		'BitmapFilterQuality': {
\			'__menuItem__': {
\				'word': 'BitmapFilterQuality'
\			}
\		},
\		'BitmapFilterType': {
\			'__menuItem__': {
\				'word': 'BitmapFilterType'
\			}
\		},
\		'BlurFilter': {
\			'__menuItem__': {
\				'word': 'BlurFilter'
\			}
\		},
\		'ColorMatrixFilter': {
\			'__menuItem__': {
\				'word': 'ColorMatrixFilter'
\			}
\		},
\		'ConvolutionFilter': {
\			'__menuItem__': {
\				'word': 'ConvolutionFilter'
\			}
\		},
\		'DisplacementMapFilter': {
\			'__menuItem__': {
\				'word': 'DisplacementMapFilter'
\			}
\		},
\		'DisplacementMapFilterMode': {
\			'__menuItem__': {
\				'word': 'DisplacementMapFilterMode'
\			}
\		},
\		'DropShadowFilter': {
\			'__menuItem__': {
\				'word': 'DropShadowFilter'
\			}
\		},
\		'GlowFilter': {
\			'__menuItem__': {
\				'word': 'GlowFilter'
\			}
\		},
\		'GradientBevelFilter': {
\			'__menuItem__': {
\				'word': 'GradientBevelFilter'
\			}
\		},
\		'GradientGlowFilter': {
\			'__menuItem__': {
\				'word': 'GradientGlowFilter'
\			}
\		}
\	},
\	'geom': {
\		'__menuItem__': { 
\			'word': 'geom'
\		},
\		'ColorTransform': {
\			'__menuItem__': {
\				'word': 'ColorTransform'
\			}
\		},
\		'Matrix': {
\			'__menuItem__': {
\				'word': 'Matrix'
\			}
\		},
\		'Point': {
\			'__menuItem__': {
\				'word': 'Point'
\			}
\		},
\		'Rectangle': {
\			'__menuItem__': {
\				'word': 'Rectangle'
\			}
\		},
\		'Transform': {
\			'__menuItem__': {
\				'word': 'Transform'
\			}
\		}
\	},
\	'html': {
\		'__menuItem__': { 
\			'word': 'html'
\		},
\		'HTMLControl': {
\			'__menuItem__': {
\				'word': 'HTMLControl'
\			}
\		},
\		'HTMLHost': {
\			'__menuItem__': {
\				'word': 'HTMLHost'
\			}
\		},
\		'HTMLPDFCapability': {
\			'__menuItem__': {
\				'word': 'HTMLPDFCapability'
\			}
\		},
\		'HTMLWindowCreateOptions': {
\			'__menuItem__': {
\				'word': 'HTMLWindowCreateOptions'
\			}
\		},
\		'JavaScriptFunction': {
\			'__menuItem__': {
\				'word': 'JavaScriptFunction'
\			}
\		},
\		'JavaScriptObject': {
\			'__menuItem__': {
\				'word': 'JavaScriptObject'
\			}
\		}
\	},
\	'media': {
\		'__menuItem__': { 
\			'word': 'media'
\		},
\		'Camera': {
\			'__menuItem__': {
\				'word': 'Camera'
\			}
\		},
\		'ID3Info': {
\			'__menuItem__': {
\				'word': 'ID3Info'
\			}
\		},
\		'Microphone': {
\			'__menuItem__': {
\				'word': 'Microphone'
\			}
\		},
\		'Sound': {
\			'__menuItem__': {
\				'word': 'Sound'
\			}
\		},
\		'SoundChannel': {
\			'__menuItem__': {
\				'word': 'SoundChannel'
\			}
\		},
\		'SoundLoaderContext': {
\			'__menuItem__': {
\				'word': 'SoundLoaderContext'
\			}
\		},
\		'SoundMixer': {
\			'__menuItem__': {
\				'word': 'SoundMixer'
\			}
\		},
\		'SoundTransform': {
\			'__menuItem__': {
\				'word': 'SoundTransform'
\			}
\		},
\		'Video': {
\			'__menuItem__': {
\				'word': 'Video'
\			}
\		}
\	},
\	'net': {
\		'__menuItem__': { 
\			'word': 'net'
\		},
\		'getClassByAlias': {
\			'__menuItem__': {
\				'word': 'getClassByAlias'
\			}
\		},
\		'navigateToURL': {
\			'__menuItem__': {
\				'word': 'navigateToURL'
\			}
\		},
\		'registerClassAlias': {
\			'__menuItem__': {
\				'word': 'registerClassAlias'
\			}
\		},
\		'sendToURL': {
\			'__menuItem__': {
\				'word': 'sendToURL'
\			}
\		},
\		'IDynamicPropertyOutput': {
\			'__menuItem__': {
\				'word': 'IDynamicPropertyOutput'
\			}
\		},
\		'IDynamicPropertyWriter': {
\			'__menuItem__': {
\				'word': 'IDynamicPropertyWriter'
\			}
\		},
\		'FileFilter': {
\			'__menuItem__': {
\				'word': 'FileFilter'
\			}
\		},
\		'FileReference': {
\			'__menuItem__': {
\				'word': 'FileReference'
\			}
\		},
\		'FileReferenceList': {
\			'__menuItem__': {
\				'word': 'FileReferenceList'
\			}
\		},
\		'LocalConnection': {
\			'__menuItem__': {
\				'word': 'LocalConnection'
\			}
\		},
\		'NetConnection': {
\			'__menuItem__': {
\				'word': 'NetConnection'
\			}
\		},
\		'NetStream': {
\			'__menuItem__': {
\				'word': 'NetStream'
\			}
\		},
\		'ObjectEncoding': {
\			'__menuItem__': {
\				'word': 'ObjectEncoding'
\			}
\		},
\		'Responder': {
\			'__menuItem__': {
\				'word': 'Responder'
\			}
\		},
\		'SharedObject': {
\			'__menuItem__': {
\				'word': 'SharedObject'
\			}
\		},
\		'SharedObjectFlushStatus': {
\			'__menuItem__': {
\				'word': 'SharedObjectFlushStatus'
\			}
\		},
\		'Socket': {
\			'__menuItem__': {
\				'word': 'Socket'
\			}
\		},
\		'URLLoader': {
\			'__menuItem__': {
\				'word': 'URLLoader'
\			}
\		},
\		'URLLoaderDataFormat': {
\			'__menuItem__': {
\				'word': 'URLLoaderDataFormat'
\			}
\		},
\		'URLRequest': {
\			'__menuItem__': {
\				'word': 'URLRequest'
\			}
\		},
\		'URLRequestDefaults': {
\			'__menuItem__': {
\				'word': 'URLRequestDefaults'
\			}
\		},
\		'URLRequestHeader': {
\			'__menuItem__': {
\				'word': 'URLRequestHeader'
\			}
\		},
\		'URLRequestMethod': {
\			'__menuItem__': {
\				'word': 'URLRequestMethod'
\			}
\		},
\		'URLStream': {
\			'__menuItem__': {
\				'word': 'URLStream'
\			}
\		},
\		'URLVariables': {
\			'__menuItem__': {
\				'word': 'URLVariables'
\			}
\		},
\		'XMLSocket': {
\			'__menuItem__': {
\				'word': 'XMLSocket'
\			}
\		}
\	},
\	'printing': {
\		'__menuItem__': { 
\			'word': 'printing'
\		},
\		'PrintJob': {
\			'__menuItem__': {
\				'word': 'PrintJob'
\			}
\		},
\		'PrintJobOptions': {
\			'__menuItem__': {
\				'word': 'PrintJobOptions'
\			}
\		},
\		'PrintJobOrientation': {
\			'__menuItem__': {
\				'word': 'PrintJobOrientation'
\			}
\		}
\	},
\	'profiler': {
\		'__menuItem__': { 
\			'word': 'profiler'
\		},
\		'showRedrawRegions': {
\			'__menuItem__': {
\				'word': 'showRedrawRegions'
\			}
\		}
\	},
\	'system': {
\		'__menuItem__': { 
\			'word': 'system'
\		},
\		'fscommand': {
\			'__menuItem__': {
\				'word': 'fscommand'
\			}
\		},
\		'ApplicationDomain': {
\			'__menuItem__': {
\				'word': 'ApplicationDomain'
\			}
\		},
\		'Capabilities': {
\			'__menuItem__': {
\				'word': 'Capabilities'
\			}
\		},
\		'Door': {
\			'__menuItem__': {
\				'word': 'Door'
\			}
\		},
\		'IME': {
\			'__menuItem__': {
\				'word': 'IME'
\			}
\		},
\		'IMEConversionMode': {
\			'__menuItem__': {
\				'word': 'IMEConversionMode'
\			}
\		},
\		'LoaderContext': {
\			'__menuItem__': {
\				'word': 'LoaderContext'
\			}
\		},
\		'NativeWindowCapabilities': {
\			'__menuItem__': {
\				'word': 'NativeWindowCapabilities'
\			}
\		},
\		'Security': {
\			'__menuItem__': {
\				'word': 'Security'
\			}
\		},
\		'SecurityDomain': {
\			'__menuItem__': {
\				'word': 'SecurityDomain'
\			}
\		},
\		'SecurityPanel': {
\			'__menuItem__': {
\				'word': 'SecurityPanel'
\			}
\		},
\		'Shell': {
\			'__menuItem__': {
\				'word': 'Shell'
\			}
\		},
\		'System': {
\			'__menuItem__': {
\				'word': 'System'
\			}
\		},
\		'Updater': {
\			'__menuItem__': {
\				'word': 'Updater'
\			}
\		}
\	},
\	'text': {
\		'__menuItem__': { 
\			'word': 'text'
\		},
\		'AntiAliasType': {
\			'__menuItem__': {
\				'word': 'AntiAliasType'
\			}
\		},
\		'CSMSettings': {
\			'__menuItem__': {
\				'word': 'CSMSettings'
\			}
\		},
\		'Font': {
\			'__menuItem__': {
\				'word': 'Font'
\			}
\		},
\		'FontStyle': {
\			'__menuItem__': {
\				'word': 'FontStyle'
\			}
\		},
\		'FontType': {
\			'__menuItem__': {
\				'word': 'FontType'
\			}
\		},
\		'GridFitType': {
\			'__menuItem__': {
\				'word': 'GridFitType'
\			}
\		},
\		'StaticText': {
\			'__menuItem__': {
\				'word': 'StaticText'
\			}
\		},
\		'StyleSheet': {
\			'__menuItem__': {
\				'word': 'StyleSheet'
\			}
\		},
\		'TextColorType': {
\			'__menuItem__': {
\				'word': 'TextColorType'
\			}
\		},
\		'TextDisplayMode': {
\			'__menuItem__': {
\				'word': 'TextDisplayMode'
\			}
\		},
\		'TextField': {
\			'__inheritance__': 'flash.display.InteractiveObject',
\			'__menuItem__': {
\				'word': 'TextField'
\			},
\			'alwaysShowSelection': {
\				'__menuItem__': {
\					'word': 'alwaysShowSelection'
\				}
\			},
\			'antiAliasType': {
\				'__menuItem__': {
\					'word': 'antiAliasType'
\				}
\			}
\		},
\		'TextFieldAutoSize': {
\			'__menuItem__': {
\				'word': 'TextFieldAutoSize'
\			}
\		},
\		'TextFieldType': {
\			'__menuItem__': {
\				'word': 'TextFieldType'
\			}
\		},
\		'TextFormat': {
\			'__menuItem__': {
\				'word': 'TextFormat'
\			}
\		},
\		'TextFormatAlign': {
\			'__menuItem__': {
\				'word': 'TextFormatAlign'
\			}
\		},
\		'TextLineMetrics': {
\			'__menuItem__': {
\				'word': 'TextLineMetrics'
\			}
\		},
\		'TextRenderer': {
\			'__menuItem__': {
\				'word': 'TextRenderer'
\			}
\		},
\		'TextSnapshot': {
\			'__menuItem__': {
\				'word': 'TextSnapshot'
\			}
\		}
\	},
\	'ui': {
\		'__menuItem__': { 
\			'word': 'ui'
\		},
\		'ContextMenu': {
\			'__menuItem__': {
\				'word': 'ContextMenu'
\			}
\		},
\		'ContextMenuBuiltInItems': {
\			'__menuItem__': {
\				'word': 'ContextMenuBuiltInItems'
\			}
\		},
\		'ContextMenuItem': {
\			'__menuItem__': {
\				'word': 'ContextMenuItem'
\			}
\		},
\		'Keyboard': {
\			'__menuItem__': {
\				'word': 'Keyboard'
\			}
\		},
\		'KeyEquivalent': {
\			'__menuItem__': {
\				'word': 'KeyEquivalent'
\			}
\		},
\		'KeyLocation': {
\			'__menuItem__': {
\				'word': 'KeyLocation'
\			}
\		},
\		'Mouse': {
\			'__menuItem__': {
\				'word': 'Mouse'
\			}
\		}
\	},
\	'utils': {
\		'__menuItem__': { 
\			'word': 'utils'
\		},
\		'clearInterval': {
\			'__menuItem__': {
\				'word': 'clearInterval'
\			}
\		},
\		'clearTimeout': {
\			'__menuItem__': {
\				'word': 'clearTimeout'
\			}
\		},
\		'describeType': {
\			'__menuItem__': {
\				'word': 'describeType'
\			}
\		},
\		'escapeMultiByte': {
\			'__menuItem__': {
\				'word': 'escapeMultiByte'
\			}
\		},
\		'getDefinitionByName': {
\			'__menuItem__': {
\				'word': 'getDefinitionByName'
\			}
\		},
\		'getQualifiedClassName': {
\			'__menuItem__': {
\				'word': 'getQualifiedClassName'
\			}
\		},
\		'getQualifiedSuperclassName': {
\			'__menuItem__': {
\				'word': 'getQualifiedSuperclassName'
\			}
\		},
\		'getTimer': {
\			'__menuItem__': {
\				'word': 'getTimer'
\			}
\		},
\		'setInterval': {
\			'__menuItem__': {
\				'word': 'setInterval'
\			}
\		},
\		'setTimeout': {
\			'__menuItem__': {
\				'word': 'setTimeout'
\			}
\		},
\		'unescapeMultiByte': {
\			'__menuItem__': {
\				'word': 'unescapeMultiByte'
\			}
\		},
\		'IDataInput': {
\			'__menuItem__': {
\				'word': 'IDataInput'
\			}
\		},
\		'IDataOutput': {
\			'__menuItem__': {
\				'word': 'IDataOutput'
\			}
\		},
\		'IExternalizable': {
\			'__menuItem__': {
\				'word': 'IExternalizable'
\			}
\		},
\		'ByteArray': {
\			'__menuItem__': {
\				'word': 'ByteArray'
\			}
\		},
\		'Dictionary': {
\			'__menuItem__': {
\				'word': 'Dictionary'
\			}
\		},
\		'Endian': {
\			'__menuItem__': {
\				'word': 'Endian'
\			}
\		},
\		'Proxy': {
\			'__menuItem__': {
\				'word': 'Proxy'
\			}
\		},
\		'Timer': {
\			'__menuItem__': {
\				'word': 'Timer'
\			}
\		}
\	},
\	'xml': {
\		'__menuItem__': { 
\			'word': 'xml'
\		},
\		'XMLDocument': {
\			'__menuItem__': {
\				'word': 'XMLDocument'
\			}
\		},
\		'XMLNode': {
\			'__menuItem__': {
\				'word': 'XMLNode'
\			}
\		},
\		'XMLNodeType': {
\			'__menuItem__': {
\				'word': 'XMLNodeType'
\			}
\		}
\	}
\}

let s:namespaces = {
\	's:flash': s:flash
\}
