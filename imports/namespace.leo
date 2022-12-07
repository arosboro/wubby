// The 'namespace' program.
program namespace.aleo {
    struct ascii32_encoding {
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
        a16: u8,
        a17: u8,
        a18: u8,
        a19: u8,
        a20: u8,
        a21: u8,
        a22: u8,
        a23: u8,
        a24: u8,
        a25: u8,
        a26: u8,
        a27: u8,
        a28: u8,
        a29: u8,
        a30: u8,
        a31: u8,
    }

    struct NamespaceDefinition {
        name: ascii32_encoding,
        uri: ascii32_encoding,
    }

    struct NamespaceInstance {
        namespace: NamespaceDefinition,
    }

    record Namespace {
        owner: address,
        gates: u64,
        data: NamespaceInstance,
    }

    mapping public_namespaces: address => u64;
    
    transition create_public_namespace(data: NamespaceInstance) -> public Namespace {
        assert(valid_ascii32_encoding(data));
        return Namespace {
            owner: self.caller,
            gates: 0u64,
            data
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_namespace(caller: address, record_count: u64) {
        increment(public_namespaces, caller, record_count);
    }
}
