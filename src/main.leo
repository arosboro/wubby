import utf_8_bytes16.leo;
import namespace.leo;
import element.leo;
import attribute.leo;
import attribute_state.leo;
import domain.leo;

// The 'wubby' program.
program wubby.aleo {
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

    // Make the first collection to be used as a genisis collection.
    transition setup(name: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_1: utf_8_bytes16.leo/UTF8Bytes16.record, uri32_2: utf_8_bytes16.leo/UTF8Bytes16.record) -> (Collection, namespace.leo/Namespace.record, domain.leo/Domain.record) {
        // Sequence Data
        let public_registry: bool = true;
        let id: u64 = 0u64;
        let class: Class = Class {
            is_data_type_definition: true,
            is_dapp: false,
            is_dapp_template: false,
            is_mixin: false,
            is_theme: false,
            is_operation: false,
        };
        let sequence_utf_8_bytes16s: u64 = 0u64;
        let sequence_elements: u64 = 0u64;
        let sequence_attributes: u64 = 0u64;
        let sequence_attribute_states: u64 = 0u64;
        let sequence_domains: u64 = 0u64;
        let name_id: u64 = sequence_utf_8_bytes16s;
        let sequenced_name: UTF8Bytes16 = utf_8_bytes16.leo/sequence_utf_8_bytes16(id, name_id, name);
        sequence_utf_8_bytes16s = sequence_utf_8_bytes16s + 1u64;
        let uri32_1_id: u64 = sequence_utf_8_bytes16s;
        let sequenced_uri32_1: UTF8Bytes16 = utf_8_bytes16.leo/sequence_utf_8_bytes16(id, uri32_1_id, uri32_1);
        sequence_utf_8_bytes16s = sequence_utf_8_bytes16s + 1u64;
        let uri32_2_id: u64 = sequence_utf_8_bytes16s;
        let sequenced_uri32_2: UTF8Bytes16 = utf_8_bytes16.leo/sequence_utf_8_bytes16(id, uri32_2_id, uri32_2);
        sequence_utf_8_bytes16s = sequence_utf_8_bytes16s + 1u64;
        // Create Public Namespace
        let public_namespace: Namespace = namespace.leo/register_namespace(name_id, uri32_1_id, uri32_2_id);
        // Create Domain
        let domain_id: u64 = sequence_domains;
        let domain: Domain = domain.leo/register_public_domain(name_id);
        let sequenced_domain: Domain = domain.leo/sequence_domain(id, domain_id, domain);
        sequence_domains = sequence_domains + 1u64;
        let sequence: DTDInstanceCount = DTDInstanceCount {
            utf_8_bytes16s: sequence_utf_8_bytes16s,
            elements: sequence_elements,
            attributes: sequence_attributes,
            attribute_states: sequence_attribute_states,
            domains: sequence_domains,
        };
        return (Collection {
            owner: self.caller,
            gates: 0u64,
            public_registry,
            id,
            domain_id,
            class,
            sequence,
        }, public_namespace, sequenced_domain);
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
    transition public_element_to_element(collection: Collection, parent: element.leo/Element.record, child: element.leo/Element.record) -> (element.leo/Element.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.elements;
        let sequenced_child: Element = element.leo/sequence_element(collection.id, id, child);
        return (element.leo/assign_element_to_parent(sequenced_child, parent), Collection {
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
    transition element_to_element(collection: Collection, parent: element.leo/Element.record, child: element.leo/Element.record) -> (element.leo/Element.record, Collection) {
        // assert(element.data.no_children);
        let sequences: DTDInstanceCount = collection.sequence;
        let id: u64 = sequences.elements;
        let sequenced_child: Element = element.leo/sequence_element(collection.id, id, child);
        return (element.leo/assign_element_to_parent(sequenced_child, parent), Collection {
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
                elements: sequences.elements + 1u64,
                attributes: sequences.attributes,
                attribute_states: sequences.attribute_states,
                domains: sequences.domains,
            }
        });
    }

    // Create Attribute

    // Create Public Attribute State

    // Create Attribute State

    // Create Public Domain

    // Create Domain

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