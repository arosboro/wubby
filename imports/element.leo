// The 'element' program.
program element.aleo {

    struct ElementBytes32 {
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

    struct AllowedAttributes {
        a0: ElementBytes32,
        a1: ElementBytes32,
        a2: ElementBytes32,
        a3: ElementBytes32,
        a4: ElementBytes32,
        a5: ElementBytes32,
        a6: ElementBytes32,
        a7: ElementBytes32,
        a8: ElementBytes32,
        a9: ElementBytes32,
        a10: ElementBytes32,
        a11: ElementBytes32,
        a12: ElementBytes32,
        a13: ElementBytes32,
        a14: ElementBytes32,
        a15: ElementBytes32,
        a16: ElementBytes32,
        a17: ElementBytes32,
        a18: ElementBytes32,
        a19: ElementBytes32,
        a20: ElementBytes32,
        a21: ElementBytes32,
        a22: ElementBytes32,
        a23: ElementBytes32,
        a24: ElementBytes32,
        a25: ElementBytes32,
        a26: ElementBytes32,
        a27: ElementBytes32,
        a28: ElementBytes32,
        a29: ElementBytes32,
        a30: ElementBytes32,
        a31: ElementBytes32,
    }

    struct ElementDefinition {
        keyword: ElementBytes32,
        allowed_attributes: AllowedAttributes
    }

    struct ElementInstance {
        element: ElementDefinition,
        is_root: bool,
        attribute_counter: u64,
        has_children: bool,
        content_id: u64,
    }

    record Element {
        owner: address,
        gates: u64,
        namespace_id: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        data: ElementInstance,
    }

    mapping element_registry: address => u64;
    mapping public_elements: address => u64;

    transition register_element(data: ElementInstance) -> public Element {
        // assert(validate_schema(data));
        return Element {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data, 
        } then finalize(self.caller, 1u64);
    }

    finalize register_element(caller: address, record_count: u64) {
        let count: u64 = Mapping::get_or_use(element_registry, caller, 0u64);
        Mapping::set(element_registry, caller, count + record_count);
    }

    transition create_public_element(data: ElementInstance) -> public Element {
        // assert(validate_schema(data));
        return Element {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data, 
        }; // then finalize(self.caller, 1u64);
    }

    // finalize create_public_element(caller: address, record_count: u64) {
    //     let count: u64 = Mapping::get_or_use(public_elements, caller, 0u64);
    //     Mapping::set(public_elements, caller, count + record_count);
    // }

    transition create_element(data: ElementInstance) -> Element {
        // assert(validate_schema(data));
        return Element {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data
        };
    }

    transition sequence_element(collection_id: u64, id: u64, element: Element, target_element: Element) -> Element {
        // assert(validate_schema(data));
        return Element {
            owner: element.owner,
            gates: element.gates,
            namespace_id: element.namespace_id,
            collection_id,
            id,
            target_id: target_element.id,
            data: element.data,
        };
    }
}
