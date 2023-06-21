// The 'utf_8_bytes64' program.
program utf_8_bytes64.aleo {

    record UTF8Bytes64 {
        owner: address,
        gates: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        // data: Utf8Encoding16,
        data: u64,
    }

    mapping public_utf8_bytes64: address => u64;

    transition get_utf_8_bytes64_id(utf_8_bytes64: UTF8Bytes64) -> (u64, UTF8Bytes64) {
        let id: u64 = utf_8_bytes64.id;
        if (id == 0u64) {
            return (0u64, utf_8_bytes64);
        }
        else {
            return (id, utf_8_bytes64);
        }
    }

    transition saturate_utf_8_bytes64(utf_8_bytes64: UTF8Bytes64, data: u64) -> UTF8Bytes64 {
        return UTF8Bytes64 {
            owner: utf_8_bytes64.owner,
            gates: utf_8_bytes64.gates,
            collection_id: utf_8_bytes64.collection_id,
            id: utf_8_bytes64.id,
            target_id: utf_8_bytes64.target_id,
            data,
        };
    }


    transition create_public_utf_8_bytes64() -> public UTF8Bytes64 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes64 {
            owner: self.caller,
            gates: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data: 0u64,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_utf_8_bytes64(caller: address, record_count: u64) {
        let count: u64 = Mapping::get_or_use(public_utf8_bytes64, caller, 0u64);
        Mapping::set(public_utf8_bytes64, caller, count + record_count);
    }
    
    transition create_utf_8_bytes64() -> UTF8Bytes64 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes64 {
            owner: self.caller,
            gates: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data: 0u64,
        };
    }

    transition sequence_utf_8_bytes64(collection_id: u64, id: u64, utf_8_bytes64: UTF8Bytes64) -> UTF8Bytes64 {
        // assert(utf_8_bytes64.namespace == 0u64);
        // assert(utf_8_bytes64.collection_id == 0u64);
        // assert(utf_8_bytes64.id == 0u64);
        // assert(utf_8_bytes64.target_id == 0u64);
        // assert(validate_schema(data));
        return UTF8Bytes64 {
            owner: utf_8_bytes64.owner,
            gates: utf_8_bytes64.gates,
            collection_id,
            id,
            target_id: 0u64,
            data: utf_8_bytes64.data,
        };
    }

    transition assign_to_element(utf_8_bytes64: UTF8Bytes64, target_id: u64) -> UTF8Bytes64 {
        // assert(utf_8_bytes64.namespace == 0u64);
        // assert(utf_8_bytes64.collection_id != 0u64);
        // assert(element.leo/element_is_empty(element));
        return UTF8Bytes64 {
            owner: utf_8_bytes64.owner,
            gates: utf_8_bytes64.gates,
            collection_id: utf_8_bytes64.collection_id,
            id: utf_8_bytes64.id,
            target_id,
            data: utf_8_bytes64.data,
        };
    }

    transition assign_to_attribute_state(utf_8_bytes64: UTF8Bytes64, target_id: u64) -> UTF8Bytes64 {
        // assert(utf_8_bytes64.namespace == 0u64);
        // assert(utf_8_bytes64.collection_id != 0u64);
        // assert(attribute_state.leo/attribute_is_empty(attribute_state));
        return UTF8Bytes64 {
            owner: utf_8_bytes64.owner,
            gates: utf_8_bytes64.gates,
            collection_id: utf_8_bytes64.collection_id,
            id: utf_8_bytes64.id,
            target_id,
            data: utf_8_bytes64.data,
        };
    }

    transition assign_and_sequence_to_element(collection_id: u64, id: u64, child: UTF8Bytes64, element_id: u64) -> UTF8Bytes64 {
        // assert(child.namespace == 0u64);
        // assert(child.collection_id == 0u64);
        // assert(child.id == 0u64);
        // assert(child.target_id == 0u64);
        // assert(element.leo/element_is_empty(element));
        return UTF8Bytes64 {
            owner: child.owner,
            gates: child.gates,
            collection_id,
            id,
            target_id: element_id,
            data: child.data,
        };
    }
}
