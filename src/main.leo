import utf_8_bytes64.leo;
import namespace.leo;
import element.leo;
import attribute.leo;
import attribute_state.leo;
import domain.leo;

// The 'wubby' program.
program wubby.aleo {
    // UTF-8 Ascii String (Belongs with the UTF-8 Ascii String library)
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

    function valid_utf8_encoding(a: Utf8Encoding16) -> bool {
        return a.a0 < 128u8 && a.a1 < 128u8 && a.a2 < 128u8 && a.a3 < 128u8 && a.a4 < 128u8 && a.a5 < 128u8 && a.a6 < 128u8 && a.a7 < 128u8 && a.a8 < 128u8 && a.a9 < 128u8 && a.a10 < 128u8 && a.a11 < 128u8 && a.a12 < 128u8 && a.a13 < 128u8 && a.a14 < 128u8 && a.a15 < 128u8;
    }

    // Collection data structures
    struct Class {
        is_data_type_definition: bool,
        is_dapp: bool,
        is_dapp_template: bool,
        is_mixin: bool,
        is_theme: bool,
        is_operation: bool,
    }

    struct DTDInstanceCount {
        utf8s: u64,
        elements: u64,
        attributes: u64,
        attribute_states: u64,
        domains: u64,
    }

    record Collection {
        owner: address,
        gates: u64,
        public_registry: bool,
        id: u64,
        domain_id: u64,
        class: Class,
        sequence: DTDInstanceCount,
    }

    mapping dapps: address => u64;
    mapping dapp_templates: address => u64;
    mapping mixins: address => u64;
    mapping themes: address => u64;
    mapping operations: address => u64;

    // Create UTF-8 Ascii String
    transition create_and_saturate_utf8(collection: Collection, value: u64) -> (utf_8_bytes64.leo/UTF8Bytes64.record, Collection) {
        // assert(valid_utf8_encoding(value));
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.utf8s;
        let new_utf8: UTF8Bytes64 = utf_8_bytes64.leo/create_utf_8_bytes64();
        let saturated_utf8: UTF8Bytes64 = utf_8_bytes64.leo/saturate_utf_8_bytes64(new_utf8, value);
        return (utf_8_bytes64.leo/sequence_utf_8_bytes64(collection.id, id, saturated_utf8), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s + 1u64,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Make the first collection to be used as a genisis collection.
    transition setup_namespace(name: u64, uri: u64) -> namespace.leo/Namespace.record {
        return namespace.leo/register_namespace(name, uri);
    }

    // Create Public Domain
    transition create_public_domain(collection: Collection, name: u64, uri: u64) -> (domain.leo/Domain.record, Collection) {
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.domains;
        let domain: Domain = domain.leo/register_public_domain(name, uri);
        return (domain.leo/sequence_domain(collection.id, id, domain), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains + 1u64,
            }
        });
    }

    // Create Domain
    transition create_domain(collection: Collection, name: u64, uri: u64) -> (domain.leo/Domain.record, Collection) {
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.domains;
        let domain: Domain = domain.leo/register_domain(name, uri);
        return (domain.leo/sequence_domain(collection.id, id, domain), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains + 1u64,
            }
        });
    }

    // Create Public String

    // Assign Public String to Element
    transition public_utf8_to_element(collection: Collection, parent: element.leo/Element.record, child: utf_8_bytes64.leo/UTF8Bytes64.record) -> (utf_8_bytes64.leo/UTF8Bytes64.record, element.leo/Element.record, Collection) {
        // assert(!element.has_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.utf8s;
        let parent_tuple: (u64, Element) = element.leo/get_element_id(parent);
        return (utf_8_bytes64.leo/assign_and_sequence_to_element(collection.id, id, child, parent_tuple.0), parent_tuple.1, Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s + 1u64,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign String to Selement
    transition utf8_to_element(collection: Collection, parent: element.leo/Element.record, child: utf_8_bytes64.leo/UTF8Bytes64.record) -> (utf_8_bytes64.leo/UTF8Bytes64.record, element.leo/Element.record, Collection) {
        // assert(!element.has_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.utf8s;
        let parent_tuple: (u64, Element) = element.leo/get_element_id(parent);
        return (utf_8_bytes64.leo/assign_and_sequence_to_element(collection.id, id, child, parent_tuple.0), parent_tuple.1, Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s + 1u64,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign Public Element to Element
    transition public_element_to_element(collection: Collection, parent: element.leo/Element.record, child: element.leo/Element.record) -> (element.leo/Element.record, element.leo/Element.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.elements;
        let sequenced_child: Element = element.leo/sequence_element(collection.id, id, child);
        let element_tuple: (Element, Element) = element.leo/assign_element_to_parent(sequenced_child, parent);
        return (element_tuple.0, element_tuple.1, Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements + 1u64,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign Element to Element
    transition element_to_element(collection: Collection, parent: element.leo/Element.record, child: element.leo/Element.record) -> (element.leo/Element.record, element.leo/Element.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.elements;
        let sequenced_child: Element = element.leo/sequence_element(collection.id, id, child);
        let element_tuple: (Element, Element) = element.leo/assign_element_to_parent(sequenced_child, parent);
        return (element_tuple.0, element_tuple.1, Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements + 1u64,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign Public Attribute to Element
    transition public_attribute_to_element(collection: Collection, parent: element.leo/Element.record, child: attribute.leo/Attribute.record) -> (attribute.leo/Attribute.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.attributes;
        let sequenced_child: Attribute = attribute.leo/sequence_attribute(collection.id, id, child);
        let target_tuple: (u64, Element) = element.leo/get_element_id(parent);
        return (attribute.leo/assign_attribute_to_parent(target_tuple.0, sequenced_child), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements,
                attributes: sequences.attributes + 1u64,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign Attribute to Element
    transition attribute_to_element(collection: Collection, parent: element.leo/Element.record, child: attribute.leo/Attribute.record) -> (attribute.leo/Attribute.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.attributes;
        let sequenced_child: Attribute = attribute.leo/sequence_attribute(collection.id, id, child);
        let target_tuple: (u64, Element) = element.leo/get_element_id(parent);
        return (attribute.leo/assign_attribute_to_parent(target_tuple.0, sequenced_child), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements,
                attributes: sequences.attributes + 1u64,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign Public Attribute State to Attribute
    transition public_attr_state_to_attribute(collection: Collection, parent: attribute.leo/Attribute.record, child: attribute_state.leo/AttributeState.record) -> (attribute_state.leo/AttributeState.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.attribute_states;
        let sequenced_child: AttributeState = attribute_state.leo/sequence_attribute_state(collection.id, id, child);
        let target_tuple: (u64, Attribute) = attribute.leo/get_attribute_id(parent);
        return (attribute_state.leo/assign_to_attribute(target_tuple.0, sequenced_child), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states + 1u64,
                domains: sequences.domains,
            }
        });
    }

    // Assign Attribute State to Attribute
    transition attr_state_to_attribute(collection: Collection,parent: attribute.leo/Attribute.record, child: attribute_state.leo/AttributeState.record) -> (attribute_state.leo/AttributeState.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.attribute_states;
        let sequenced_child: AttributeState = attribute_state.leo/sequence_attribute_state(collection.id, id, child);
        let target_tuple: (u64, Attribute) = attribute.leo/get_attribute_id(parent);
        return (attribute_state.leo/assign_to_attribute(target_tuple.0, sequenced_child), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf8s: sequences.utf8s,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states + 1u64,
                domains: sequences.domains,
            }
        });
    }

    transition main(class: Class) -> Collection {
        return Collection {
            owner: self.caller,
            gates: 0u64,
            public_registry: false,
            id: 0u64,
            domain_id: 0u64,
            class,
            sequence: DTDInstanceCount {
                utf8s: 0u64,
                elements: 0u64,
                attributes: 0u64,
                attribute_states: 0u64,
                domains: 0u64,
            }
        };
    }

    transition publish(collection: Collection) -> public Collection {
        return Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: true,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: collection.sequence,
        };
    }
}