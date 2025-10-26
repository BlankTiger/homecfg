import lldb


def array_summary(valobj, internal_dict):
    count = valobj.GetChildMemberWithName("count").GetValueAsUnsigned(0)
    return f"[{count}]"


def array_synthetic_children(valobj, internal_dict):
    class ArraySynthProvider:
        def __init__(self, valobj):
            self.valobj = valobj
            self.update()

        def num_children(self):
            return self.count

        def get_child_index(self, name):
            try:
                return int(name.lstrip("[").rstrip("]"))
            except:
                return -1

        def get_child_at_index(self, index):
            if index < 0 or index >= self.num_children():
                return None
            if self.data_ptr is None or not self.data_ptr.IsValid():
                return None
            offset = index * self.element_type.GetByteSize()
            return self.data_ptr.CreateChildAtOffset(f"[{index}]", offset, self.element_type)

        def update(self):
            self.count = self.valobj.GetChildMemberWithName("count").GetValueAsUnsigned(0)
            data_member = self.valobj.GetChildMemberWithName("data")
            self.data_ptr = data_member
            self.element_type = data_member.GetType().GetPointeeType()

        def has_children(self):
            return self.count > 0

    return ArraySynthProvider(valobj)


def __lldb_init_module(debugger, internal_dict):
    # Try multiple type name patterns
    debugger.HandleCommand('type summary add -x ".*\[\.\.\\].*" -F jai_lldb.array_summary -w jai')
    debugger.HandleCommand(
        'type synthetic add -x ".*\[\.\.\\].*" -l jai_lldb.array_synthetic_children -w jai'
    )

    # Also try matching struct names that might contain array info
    debugger.HandleCommand('type summary add -x "^.*Array<.*>$" -F jai_lldb.array_summary -w jai')
    debugger.HandleCommand(
        'type synthetic add -x "^.*Array<.*>$" -l jai_lldb.array_synthetic_children -w jai'
    )

    debugger.HandleCommand("type category enable jai")
