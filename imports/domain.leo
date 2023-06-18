// The 'domain' program.
program domain.aleo {

    record Domain {
        owner: address,
        gates: u64,
        // DTD: DomainDefinition,
        name: u64,
        uri32_0_16: u64,
        uri32_17_32: u64,
        // DomainInstance
        id: u64,
        collection_id: u64,
    }

    mapping public_domains: address => u64;

    transition register_public_domain(name: u64, uri32_0_16: u64, uri32_17_32: u64) -> public Domain {
        // assert(valid_domain(data));
        return Domain {
            owner: self.caller,
            gates: 0u64,
            name,
            uri32_0_16,
            uri32_17_32,
            id: 0u64,
            collection_id: 0u64,
        } then finalize(self.caller, 1u64);
    }

    finalize register_public_domain(caller: address, records: u64) {
        let count: u64 = Mapping::get_or_use(public_domains, caller, 0u64);
        Mapping::set(public_domains, caller, count + records);
    }

    transition register_domain(name: u64, uri32_0_16: u64, uri32_17_32: u64) -> Domain {
        // assert(valid_domain(data));
        return Domain {
            owner: self.caller,
            gates: 0u64,
            name,
            uri32_0_16,
            uri32_17_32,
            id: 0u64,
            collection_id: 0u64,
        };
    }

    transition sequence_domain(id: u64, collection_id: u64, domain: Domain) -> Domain {
        // assert(valid_utf8_encoding(data));
        return Domain {
            owner: domain.owner,
            gates: domain.gates,
            name: domain.name,
            uri32_0_16: domain.uri32_0_16,
            uri32_17_32: domain.uri32_17_32,
            id,
            collection_id,
        };
    }
}