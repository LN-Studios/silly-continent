extends Node

## filter to exclude self from selection
func exclude_self(obj_self: Object) -> Callable: 
	return (func(obj_comp: Object): return obj_self != obj_comp)
	
## make new array only with elements that return true from `filter`
func filter_array(arr: Array, filter: Callable) -> Array:
	var new_arr = []
	for item in arr:
		if (filter.call(item)):
			new_arr.append(item)
	return new_arr

## returns new array that is a copy of `arr`, sorted by filter
func sort_array(arr: Array, filter: Callable) -> Array:
	var sorted = []
	sorted.append_array(arr)
	sorted.sort_custom(filter)
	return sorted

## selects a random element from `arr`, or null if array is empty
func select_random(arr: Array) -> Variant:
	if (arr.is_empty()):
		return null
	else:
		var index = randi_range(0, arr.size() - 1)
		return arr[index]
