// The 'namespace' program.
program namespace.aleo {

    record Namespace {
        owner: address,
        gates: u64,
        id: u64,
        // DTD: Namespace
        name: u64,
        uri: u64,
    }

    mapping public_namespaces: address => u64;

    transition register_namespace(name: u64, uri: u64) -> public Namespace {
        return Namespace {
            owner: self.caller,
            gates: 0u64,
            id: 0u64,
            name,
            uri,
        } then finalize(self.caller, 1u64);
    }

    finalize register_namespace(caller: address, records: u64) {
        let count: u64 = Mapping::get_or_use(public_namespaces, caller, 0u64);
        Mapping::set(public_namespaces, caller, count + records);
    }
}