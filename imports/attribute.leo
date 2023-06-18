// The 'attribute' program.
program attribute.aleo {

    struct AttributeBytes32 {
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

    struct AllowedStates {
        a0: AttributeBytes32,
        a1: AttributeBytes32,
        a2: AttributeBytes32,
        a3: AttributeBytes32,
        a4: AttributeBytes32,
        a5: AttributeBytes32,
        a6: AttributeBytes32,
        a7: AttributeBytes32,
        a8: AttributeBytes32,
        a9: AttributeBytes32,
        a10: AttributeBytes32,
        a11: AttributeBytes32,
        a12: AttributeBytes32,
        a13: AttributeBytes32,
        a14: AttributeBytes32,
        a15: AttributeBytes32,
        a16: AttributeBytes32,
        a17: AttributeBytes32,
        a18: AttributeBytes32,
        a19: AttributeBytes32,
        a20: AttributeBytes32,
        a21: AttributeBytes32,
        a22: AttributeBytes32,
        a23: AttributeBytes32,
        a24: AttributeBytes32,
        a25: AttributeBytes32,
        a26: AttributeBytes32,
        a27: AttributeBytes32,
        a28: AttributeBytes32,
        a29: AttributeBytes32,
        a30: AttributeBytes32,
        a31: AttributeBytes32,
    }
    
    struct AttributeDefinition {
        keyword: AttributeBytes32,
        allowed_states: AllowedStates,
        is_global: bool,
    }

    struct AttributeInstance {
        attribute: AttributeDefinition,
        state: AttributeBytes32,
    }

    record Attribute {
        owner: address,
        gates: u64,
        namespace_id: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        data: AttributeInstance,
    }

    mapping attribute_registry: address => u64;
    mapping public_attributes: address => u64;

    transition register_attribute(data: AttributeInstance) -> public Attribute {
        return Attribute {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        } then finalize(self.caller, 1u64);
    }

    finalize register_attribute(caller: address, record_count: u64) {
        let count: u64 = Mapping::get_or_use(attribute_registry, caller, 0u64);
        Mapping::set(attribute_registry, caller, count + record_count);
    }

    transition create_public_attribute(data: AttributeInstance) -> public Attribute {
        return Attribute {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_attribute(caller: address, records: u64) {
        let count: u64 = Mapping::get_or_use(public_attributes, caller, 0u64);
        Mapping::set(public_attributes, caller, count + records);
    }

    transition create_attribute(data: AttributeInstance) -> private Attribute {
        return Attribute {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        };
    }

    transition sequence_attribute(collection_id: u64, id: u64, target_id: u64, attribute: Attribute) -> Attribute {
        return Attribute {
            owner: attribute.owner,
            gates: attribute.gates,
            namespace_id: attribute.namespace_id,
            collection_id,
            id,
            target_id,
            data: attribute.data,
        };
    }
}