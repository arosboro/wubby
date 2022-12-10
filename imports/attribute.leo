// The 'attribute' program.
program attribute.aleo {

    record Attribute {
        owner: address,
        gates: u64,
        namespace_id: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        // dtd: Attribute
        keyword: u64,
        is_global: bool,
        // data: AttributeInstance
        state: u64,
    }

    mapping attribute_registry: address => u64;
    mapping public_attributes: address => u64;

    transition get_attribute_id(attribute: Attribute) -> (u64, Attribute) {
        let id: u64 = attribute.id;
        if (id == 0u64) {
            return (0u64, attribute);
        }
        else {
            return (id, attribute);
        }
    }

    transition register_attribute(keyword: u64, is_global: bool, state: u64) -> public Attribute {
        return Attribute {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_global,
            state,
        } then finalize(self.caller, 1u64);
    }

    finalize register_attribute(caller: address, record_count: u64) {
        increment(attribute_registry, caller, record_count);
    }

    transition create_public_attribute(keyword: u64, is_global: bool, state: u64) -> public Attribute {
        return Attribute {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_global,
            state,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_attribute(caller: address, records: u64) {
        increment(public_attributes, caller, records);
    }

    transition create_attribute(keyword: u64, is_global: bool, state: u64) -> private Attribute {
        return Attribute {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_global,
            state,
        };
    }

    transition sequence_attribute(collection_id: u64, id: u64, attribute: Attribute) -> Attribute {
        return Attribute {
            owner: attribute.owner,
            gates: attribute.gates,
            namespace_id: attribute.namespace_id,
            collection_id,
            id,
            target_id: 0u64,
            keyword: attribute.keyword,
            is_global: attribute.is_global,
            state: attribute.state,
        };
    }

    transition assign_attribute_to_parent(parent_id: u64, child: Attribute) -> Attribute {
        // assert(parent.namespace == 0u64);
        // assert(parent.collection_id != 0u64);
        // assert((parent.is_root && parent.id == 0u64 && parent.target_id == 0u64) || (!parent.is_root && parent.id != 0u64));
        // assert(child.namespace == 0u64);
        // assert(child.collection_id != 0u64);
        // assert(child.id != 0u64);
        // assert(child.target_id == 0u64);
        return Attribute {
            owner: child.owner,
            gates: child.gates,
            namespace_id: child.namespace_id,
            collection_id: child.collection_id,
            id: child.id,
            target_id: parent_id,
            keyword: child.keyword,
            is_global: child.is_global,
            state: child.state,
        };
    }
}