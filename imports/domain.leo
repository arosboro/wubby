// The 'domain' program.
program domain.aleo {

    record Domain {
        owner: address,
        gates: u64,
        // DTD: DomainDefinition,
        name: u64,
        // DomainInstance
        id: u64,
        collection_id: u64,
    }

    mapping public_domains: address => u64;

    transition register_public_domain(name: u64) -> public Domain {
        // assert(valid_domain(data));
        return Domain {
            owner: self.caller,
            gates: 0u64,
            name,
            id: 0u64,
            collection_id: 0u64,
        } then finalize(self.caller, 1u64);
    }

    finalize register_public_domain(caller: address, records: u64) {
        increment(public_domains, caller, records);
    }

    transition register_domain(name: u64) -> public Domain {
        // assert(validate_schema(data));
        return Domain {
            owner: self.caller,
            gates: 0u64,
            name,
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
            id,
            collection_id,
        };
    }
}