// The 'attribute_state' program.
program attribute_state.aleo {

    record AttributeState {
        owner: address,
        gates: u64,
        // DTD: AttributeStateDefinition
        keyword: u64,
        // AttributeStateInstance
        namespace_id: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        is_freetext: bool,
        freetext: u64,
    }

    mapping attribute_state_registry: address => u64;
    mapping public_attribute_states: address => u64;

    transition register_attribute_state(keyword: u64, is_freetext: bool, freetext: u64) -> public AttributeState {
        return AttributeState {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_freetext,
            freetext,
        } then finalize(self.caller, 1u64);
    }

    finalize register_attribute_state(caller: address, records: u64) {
        let count: u64 = Mapping::get_or_use(attribute_state_registry, caller, 0u64);
        Mapping::set(attribute_state_registry, caller, count + records);
    }

    transition create_public_attribute_state(keyword: u64, is_freetext: bool, freetext: u64) -> public AttributeState {
        return AttributeState {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_freetext,
            freetext,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_attribute_state(caller: address, records: u64) {
        let count: u64 = Mapping::get_or_use(public_attribute_states, caller, 0u64);
        Mapping::set(public_attribute_states, caller, count + records);
    }

    transition create_attribute_state(keyword: u64, is_freetext: bool, freetext: u64) -> AttributeState {
        return AttributeState {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_freetext,
            freetext,
        };
    }

    transition sequence_attribute_state(collection_id: u64, id: u64, attribute_state: AttributeState) -> AttributeState {
        // assert(attribute_state.namespace == 0u64);
        // assert(attribute_state.collection_id == 0u64);
        // assert(attribute_state.id == 0u64);
        // assert(attribute_state.target_id == 0u64);
        // assert(validate_schema(data));
        return AttributeState {
            owner: attribute_state.owner,
            gates: attribute_state.gates,
            namespace_id: attribute_state.namespace_id,
            collection_id,
            id,
            target_id: 0u64,
            keyword: attribute_state.keyword,
            is_freetext: attribute_state.is_freetext,
            freetext: attribute_state.freetext,
        };
    }

    transition assign_to_attribute(target_id: u64, attribute_state: AttributeState) -> AttributeState {
        // assert(attribute_state.namespace == 0u64);
        // assert(attribute_state.collection_id != 0u64);
        return AttributeState {
            owner: attribute_state.owner,
            gates: attribute_state.gates,
            namespace_id: attribute_state.namespace_id,
            collection_id: attribute_state.collection_id,
            id: attribute_state.id,
            target_id,
            keyword: attribute_state.keyword,
            is_freetext: attribute_state.is_freetext,
            freetext: attribute_state.freetext,
        };
    }
}