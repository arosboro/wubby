// The 'utf_8_bytes16' program.
program utf_8_bytes16.aleo {

    struct Utf8Encoding16 {
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
    }

    record UTF8Bytes16 {
        owner: address,
        gates: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        // data: Utf8Encoding16,
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
    }

    mapping public_utf8_bytes16: address => u64;

    transition get_utf_8_bytes16_id(utf_8_bytes16: UTF8Bytes16) -> (u64, UTF8Bytes16) {
        let id: u64 = utf_8_bytes16.id;
        if (id == 0u64) {
            return (0u64, utf_8_bytes16);
        }
        else {
            return (id, utf_8_bytes16);
        }
    }
    
    transition create_public_utf_8_bytes16(data: Utf8Encoding16) -> public UTF8Bytes16 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes16 {
            owner: self.caller,
            gates: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            a0: data.a0,
            a1: data.a1,
            a2: data.a2,
            a3: data.a3,
            a4: data.a4,
            a5: data.a5,
            a6: data.a6,
            a7: data.a7,
            a8: data.a8,
            a9: data.a9,
            a10: data.a10,
            a11: data.a11,
            a12: data.a12,
            a13: data.a13,
            a14: data.a14,
            a15: data.a15,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_utf_8_bytes16(caller: address, record_count: u64) {
        increment(public_utf8_bytes16, caller, record_count);
    }
    
    transition create_utf_8_bytes16(data: Utf8Encoding16) -> UTF8Bytes16 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes16 {
            owner: self.caller,
            gates: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            a0: data.a0,
            a1: data.a1,
            a2: data.a2,
            a3: data.a3,
            a4: data.a4,
            a5: data.a5,
            a6: data.a6,
            a7: data.a7,
            a8: data.a8,
            a9: data.a9,
            a10: data.a10,
            a11: data.a11,
            a12: data.a12,
            a13: data.a13,
            a14: data.a14,
            a15: data.a15,
        };
    }

    function sequence_utf_8_bytes16(collection_id: u64, id: u64, utf_8_bytes16: UTF8Bytes16) -> UTF8Bytes16 {
        // assert(utf_8_bytes16.namespace == 0u64);
        // assert(utf_8_bytes16.collection_id == 0u64);
        // assert(utf_8_bytes16.id == 0u64);
        // assert(utf_8_bytes16.target_id == 0u64);
        // assert(validate_schema(data));
        return UTF8Bytes16 {
            owner: utf_8_bytes16.owner,
            gates: utf_8_bytes16.gates,
            collection_id,
            id,
            target_id: 0u64,
            a0: utf_8_bytes16.a0,
            a1: utf_8_bytes16.a1,
            a2: utf_8_bytes16.a2,
            a3: utf_8_bytes16.a3,
            a4: utf_8_bytes16.a4,
            a5: utf_8_bytes16.a5,
            a6: utf_8_bytes16.a6,
            a7: utf_8_bytes16.a7,
            a8: utf_8_bytes16.a8,
            a9: utf_8_bytes16.a9,
            a10: utf_8_bytes16.a10,
            a11: utf_8_bytes16.a11,
            a12: utf_8_bytes16.a12,
            a13: utf_8_bytes16.a13,
            a14: utf_8_bytes16.a14,
            a15: utf_8_bytes16.a15,
        };
    }

    transition assign_to_element(utf_8_bytes16: UTF8Bytes16, target_id: u64) -> UTF8Bytes16 {
        // assert(utf_8_bytes16.namespace == 0u64);
        // assert(utf_8_bytes16.collection_id != 0u64);
        // assert(element.leo/element_is_empty(element));
        return UTF8Bytes16 {
            owner: utf_8_bytes16.owner,
            gates: utf_8_bytes16.gates,
            collection_id: utf_8_bytes16.collection_id,
            id: utf_8_bytes16.id,
            target_id,
            a0: utf_8_bytes16.a0,
            a1: utf_8_bytes16.a1,
            a2: utf_8_bytes16.a2,
            a3: utf_8_bytes16.a3,
            a4: utf_8_bytes16.a4,
            a5: utf_8_bytes16.a5,
            a6: utf_8_bytes16.a6,
            a7: utf_8_bytes16.a7,
            a8: utf_8_bytes16.a8,
            a9: utf_8_bytes16.a9,
            a10: utf_8_bytes16.a10,
            a11: utf_8_bytes16.a11,
            a12: utf_8_bytes16.a12,
            a13: utf_8_bytes16.a13,
            a14: utf_8_bytes16.a14,
            a15: utf_8_bytes16.a15,
        };
    }

    transition assign_to_attribute_state(utf_8_bytes16: UTF8Bytes16, target_id: u64) -> UTF8Bytes16 {
        // assert(utf_8_bytes16.namespace == 0u64);
        // assert(utf_8_bytes16.collection_id != 0u64);
        // assert(attribute_state.leo/attribute_is_empty(attribute_state));
        return UTF8Bytes16 {
            owner: utf_8_bytes16.owner,
            gates: utf_8_bytes16.gates,
            collection_id: utf_8_bytes16.collection_id,
            id: utf_8_bytes16.id,
            target_id,
            a0: utf_8_bytes16.a0,
            a1: utf_8_bytes16.a1,
            a2: utf_8_bytes16.a2,
            a3: utf_8_bytes16.a3,
            a4: utf_8_bytes16.a4,
            a5: utf_8_bytes16.a5,
            a6: utf_8_bytes16.a6,
            a7: utf_8_bytes16.a7,
            a8: utf_8_bytes16.a8,
            a9: utf_8_bytes16.a9,
            a10: utf_8_bytes16.a10,
            a11: utf_8_bytes16.a11,
            a12: utf_8_bytes16.a12,
            a13: utf_8_bytes16.a13,
            a14: utf_8_bytes16.a14,
            a15: utf_8_bytes16.a15,
        };
    }

    transition assign_and_sequence_to_element(collection_id: u64, id: u64, child: UTF8Bytes16, element_id: u64) -> UTF8Bytes16 {
        // assert(child.namespace == 0u64);
        // assert(child.collection_id == 0u64);
        // assert(child.id == 0u64);
        // assert(child.target_id == 0u64);
        // assert(element.leo/element_is_empty(element));
        return UTF8Bytes16 {
            owner: child.owner,
            gates: child.gates,
            collection_id,
            id,
            target_id: element_id,
            a0: child.a0,
            a1: child.a1,
            a2: child.a2,
            a3: child.a3,
            a4: child.a4,
            a5: child.a5,
            a6: child.a6,
            a7: child.a7,
            a8: child.a8,
            a9: child.a9,
            a10: child.a10,
            a11: child.a11,
            a12: child.a12,
            a13: child.a13,
            a14: child.a14,
            a15: child.a15,
        };
    }

    function valid_utf8_encoding(a: Utf8Encoding16) -> bool {
        return a.a0 < 128u8 && a.a1 < 128u8 && a.a2 < 128u8 && a.a3 < 128u8 && a.a4 < 128u8 && a.a5 < 128u8 && a.a6 < 128u8 && a.a7 < 128u8 && a.a8 < 128u8 && a.a9 < 128u8 && a.a10 < 128u8 && a.a11 < 128u8 && a.a12 < 128u8 && a.a13 < 128u8 && a.a14 < 128u8 && a.a15 < 128u8;
    }
}
