import lldb


def is_odin_slice_type(type_obj, internal_dict):
    name = type_obj.GetDisplayTypeName() or ""
    return (
        name.startswith("[]")
        or name.startswith("[dynamic]")
        or name.startswith("[dynamic;")
    ) and not name.endswith("]")


def slice_summary(value, internal_dict):
    value = value.GetNonSyntheticValue()
    length = value.GetChildMemberWithName("len").GetValueAsUnsigned(0)
    return "[%d]" % length


class SliceChildrenProvider:
    def __init__(self, value, internal_dict):
        self.value = value
        self.update()

    def update(self):
        value = self.value.GetNonSyntheticValue()
        length = value.GetChildMemberWithName("len")
        data = value.GetChildMemberWithName("data")

        self.length = length.GetValueAsUnsigned(0)
        self.data = data
        self.element_type = data.GetType().GetPointeeType()
        return False

    def has_children(self):
        return self.length > 0

    def num_children(self):
        return self.length

    def get_child_index(self, name):
        try:
            return int(name.lstrip("[").rstrip("]"))
        except ValueError:
            return -1

    def get_child_at_index(self, index):
        if index < 0 or index >= self.length:
            return None
        if not self.data.IsValid() or not self.element_type.IsValid():
            return None

        offset = index * self.element_type.GetByteSize()
        return self.data.CreateChildAtOffset(
            "[%d]" % index, offset, self.element_type
        )


def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand(
        "type summary add --python-function "
        "odin_lldb.slice_summary --recognizer-function "
        "odin_lldb.is_odin_slice_type -w odin"
    )
    debugger.HandleCommand(
        "type synthetic add --python-class "
        "odin_lldb.SliceChildrenProvider --recognizer-function "
        "odin_lldb.is_odin_slice_type -w odin"
    )
    debugger.HandleCommand("type category enable odin")
