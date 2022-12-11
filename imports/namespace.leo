// The 'namespace' program.
program namespace.aleo {

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