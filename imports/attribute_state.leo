// The 'attribute_state' program.
program attribute_state.aleo {

    struct AttributeStateBytes32 {
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
    
    struct AttributeStateDefinition {
        keyword: AttributeStateBytes32,
    }

    struct AttributeStateInstance {
        attribute: AttributeStateDefinition,
    }

    record AttributeState {
        owner: address,
        gates: u64,
        namespace_id: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        data: AttributeStateInstance,
    }

    mapping attribute_state_registry: address => u64;
    mapping public_attribute_states: address => u64;

    transition register_attribute_state(data: AttributeStateInstance) -> public AttributeState {
        return AttributeState {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        } then finalize(self.caller, 1u64);
    }

    finalize register_attribute_state(caller: address, records: u64) {
        increment(attribute_state_registry, caller, records);
    }

    transition create_public_attribute_state(data: AttributeStateInstance) -> public AttributeState {
        return AttributeState {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_attribute_state(caller: address, records: u64) {
        increment(public_attribute_states, caller, records);
    }

    transition create_attribute_state(data: AttributeStateInstance) -> private AttributeState {
        return AttributeState {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        };
    }

    transition sequence_attribute_state(collection_id: u64, id: u64, target_id: u64, attribute_state: AttributeState) -> AttributeState {
        // assert(valid_utf8_encoding(data));
        return AttributeState {
            owner: attribute_state.owner,
            gates: attribute_state.gates,
            namespace_id: attribute_state.namespace_id,
            collection_id,
            id,
            target_id,
            data: attribute_state.data,
        };
    }
}