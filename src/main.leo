import utf_8_bytes16.leo;
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
        utf_8_bytes16s: u64
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
    transition create_and_saturate_utf8(collection: Collection, value: Utf8Encoding16) -> (utf_8_bytes16.leo/UTF8Bytes16.record, Collection) {
        // assert(valid_utf8_encoding(value));
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.utf_8_bytes16s;
        let new_utf8: UTF8Bytes16 = utf_8_bytes16.leo/create_public_utf_8_bytes16();
        let saturated_utf8_1_4: UTF8Bytes16 = utf_8_bytes16.leo/saturate_utf8_bytes_4(new_utf8, 0u8, value.a0, value.a1, value.a2, value.a3);
        let saturated_utf8_5_8: UTF8Bytes16 = utf_8_bytes16.leo/saturate_utf8_bytes_4(saturated_utf8_1_4, 4u8, value.a4, value.a5, value.a6, value.a7);
        let saturated_utf8_9_12: UTF8Bytes16 = utf_8_bytes16.leo/saturate_utf8_bytes_4(saturated_utf8_5_8, 8u8, value.a8, value.a9, value.a10, value.a11);
        let saturated_utf8_13_16: UTF8Bytes16 = utf_8_bytes16.leo/saturate_utf8_bytes_4(saturated_utf8_9_12, 12u8, value.a12, value.a13, value.a14, value.a15);
        return (utf_8_bytes16.leo/sequence_utf_8_bytes16(collection.id, id, saturated_utf8_13_16), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf_8_bytes16s: sequences.utf_8_bytes16s + 1u64,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Make the first collection to be used as a genisis collection.
    transition setup_namespace(name: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_0_16: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_17_32: utf_8_bytes16.leo/UTF8Bytes16.record, domain_name: utf_8_bytes16.leo/UTF8Bytes16.record) -> namespace.leo/Namespace.record {
        let name_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(name);
        let uri32_0_16_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(uri32_0_16);
        let uri32_17_32_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(uri32_17_32);
        return namespace.leo/register_namespace(name_id.0, uri32_0_16_id.0, uri32_17_32_id.0);
    }

    // Create Public Domain
    transition create_public_domain(collection: Collection, name: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_0_16: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_17_32: utf_8_bytes16.leo/UTF8Bytes16.record) -> (domain.leo/Domain.record, Collection) {
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.domains;
        let name_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(name);
        let uri32_0_16_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(uri32_0_16);
        let uri32_17_32_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(uri32_17_32);
        let domain: Domain = domain.leo/register_public_domain(name_id.0, uri32_0_16_id.0, uri32_17_32_id.0);
        return (domain.leo/sequence_domain(collection.id, id, domain), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf_8_bytes16s: sequences.utf_8_bytes16s,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains + 1u64,
            }
        });
    }

    // Create Domain
    transition create_domain(collection: Collection, name: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_0_16: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_17_32: utf_8_bytes16.leo/UTF8Bytes16.record) -> (domain.leo/Domain.record, Collection) {
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.domains;
        let name_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(name);
        let uri32_0_16_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(uri32_0_16);
        let uri32_17_32_id: (u64, UTF8Bytes16) = utf_8_bytes16.leo/get_utf_8_bytes16_id(uri32_17_32);
        let domain: Domain = domain.leo/register_domain(name_id.0, uri32_0_16_id.0, uri32_17_32_id.0);
        return (domain.leo/sequence_domain(collection.id, id, domain), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf_8_bytes16s: sequences.utf_8_bytes16s,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains + 1u64,
            }
        });
    }

    // Create Public String

    // Assign Public String to Element
    transition public_utf8_to_element(collection: Collection, parent: element.leo/Element.record, child: utf_8_bytes16.leo/UTF8Bytes16.record) -> (utf_8_bytes16.leo/UTF8Bytes16.record, element.leo/Element.record, Collection) {
        // assert(!element.has_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.utf_8_bytes16s;
        let parent_tuple: (u64, Element) = element.leo/get_element_id(parent);
        return (utf_8_bytes16.leo/assign_and_sequence_to_element(collection.id, id, child, parent_tuple.0), parent_tuple.1, Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf_8_bytes16s: sequences.utf_8_bytes16s + 1u64,
                elements: sequences.elements,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Assign String to Selement
    transition utf8_to_element(collection: Collection, parent: element.leo/Element.record, child: utf_8_bytes16.leo/UTF8Bytes16.record) -> (utf_8_bytes16.leo/UTF8Bytes16.record, element.leo/Element.record, Collection) {
        // assert(!element.has_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.utf_8_bytes16s;
        let parent_tuple: (u64, Element) = element.leo/get_element_id(parent);
        return (utf_8_bytes16.leo/assign_and_sequence_to_element(collection.id, id, child, parent_tuple.0), parent_tuple.1, Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: DTDInstanceCount {
                utf_8_bytes16s: sequences.utf_8_bytes16s + 1u64,
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
                utf_8_bytes16s: sequences.utf_8_bytes16s,
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
                utf_8_bytes16s: sequences.utf_8_bytes16s,
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
                utf_8_bytes16s: sequences.utf_8_bytes16s,
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
                utf_8_bytes16s: sequences.utf_8_bytes16s,
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
                utf_8_bytes16s: sequences.utf_8_bytes16s,
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
                utf_8_bytes16s: sequences.utf_8_bytes16s,
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
                utf_8_bytes16s: 0u64,
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