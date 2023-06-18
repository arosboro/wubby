// The 'domain' program.
program domain.aleo {

    struct DomainBytes32 {
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
    
    struct DomainDefinition {
        name: DomainBytes32,
    }

    struct DomainInstance {
        domain: DomainDefinition,
    }

    record Domain {
        owner: address,
        gates: u64,
        id: u64,
        collection_id: u64,
        data: DomainInstance,
    }

    mapping public_domains: address => u64;

    transition register_public_domain(data: DomainInstance) -> public Domain {
        // assert(valid_domain(data));
        return Domain {
            owner: self.caller,
            gates: 0u64,
            id: 0u64,
            collection_id: 0u64,
            data,
        } then finalize(self.caller, 1u64);
    }

    finalize register_public_domain(caller: address, records: u64) {
        let count: u64 = Mapping::get_or_use(public_domains, caller, 0u64);
        Mapping::set(public_domains, caller, count + records);
    }

    transition register_domain(data: DomainInstance) -> public Domain {
        // assert(validate_schema(data));
        return Domain {
            owner: self.caller,
            gates: 0u64,
            id: 0u64,
            collection_id: 0u64,
            data,
        };
    }

    transition sequence_domain(id: u64, collection_id: u64, domain: Domain) -> Domain {
        // assert(valid_utf8_encoding(data));
        return Domain {
            owner: domain.owner,
            gates: domain.gates,
            id,
            collection_id,
            data: domain.data,
        };
    }
}