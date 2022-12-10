// The 'namespace' program.
program namespace.aleo {

    struct NamespaceBytes16 {
        a0: u8,
        a1: u8,
        a2: u8,
        a3: u8,
        a4: u8,
        a5: u8,
        a6: u8,
        a7: u8,
        a8: u8,
        a9: u8,
        a10: u8,
        a11: u8,
        a12: u8,
        a13: u8,
        a14: u8,
        a15: u8,
    }

    struct NamespaceDefinition {
        name: NamespaceBytes16,
        uri: NamespaceBytes16,
    }

    struct NamespaceInstance {
        namespace: NamespaceDefinition,
    }

    record Namespace {
        owner: address,
        gates: u64,
        id: u64,
        // DTD: Namespace
        name: u64,
        uri32_0_16: u64,
        uri32_17_32: u64,
    }

    mapping public_namespaces: address => u64;

    transition register_namespace(name: u64, uri32_0_16: u64, uri32_17_32: u64) -> public Namespace {
        return Namespace {
            owner: self.caller,
            gates: 0u64,
            id: 0u64,
            name,
            uri32_0_16,
            uri32_17_32,
        } then finalize(self.caller, 1u64);
    }

    finalize register_namespace(caller: address, records: u64) {
        increment(public_namespaces, caller, records);
    }
}