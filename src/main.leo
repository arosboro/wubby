import ascii32.leo;

// The 'wubby' program.
program wubby.aleo {
    struct ascii32_string {
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

    struct Identifiers {
        id,
        target_dtd_id,
        target_id,
    }

    struct DomainInstance {
        name: ascii32_string,
    }

    struct NamespaceDefinition {
        name: ascii32_string,
        uri: ascii32_string,
    }

    struct NamespaceInstance {
        namespace: NamespaceDefinition,
    }

    struct ElementDefinition {
        keyword: ascii32_string,
    }

    struct ElementInstance {
        element: ElementDefinition,
        is_root: bool,
    }

    struct AttributeDefinition {
        keyword: ascii32_string,
        is_global: bool,
    }

    struct AttributeInstance {
        attribute: AttributeDefinition,
        state: ascii32_string,
    }

    record Domain {
        owner: address,
        gates: u64,
        public_registry: bool,
        collection_id: u128,
        parent_element_id: u128,
        element_id: u128,
        attribute_id: u128,
        domain: DomainInstance,
        namespace: NamespaceInstance,
        element: ElementInstance,
        attribute: AttributeInstance,

    }

    mapping domains: address => u128;
    mapping collections: address => u128;
    mapping namespaces: address => u8;
    mapping elements: address => u8;
    mapping attributes: address => u8;

    transition main(public identifiers: Identifiers, public domain: DomainInstance, public namespace: NamespaceInstance, public element: ElementInstance, public attribute: AttributeInstance) -> Domain {
        return Domain {
            owner: self.caller,
            gates: 0u64,
            public_registry: identifiers.public_registry,
            collection_id: identifiers.collection_id,
            parent_element_id: identifiers.parent_element_id,
            element_id: identifiers.element_id,
            attribute_id: identifiers.attribute_id,
            domain,
            namespace,
            element,
            attribute,
        };
    }
}