import utf_8_bytes32.leo;
import namespace.leo;
import element.leo;
import attribute.leo;
import attribute_state.leo;
import domain.leo;

// The 'wubby' program.
program wubby.aleo {
    // Collection data structures

    struct Class {
        is_dapp: bool,
        is_dapp_template: bool,
        is_mixin: bool,
        is_theme: bool,
        is_operation: bool,
    }

    struct DTDClass {
        utf8_32s: bool,
        elements: bool,
        attributes: bool,
        attribute_states: bool,
        domains: bool,
    }

    struct DTDInstanceCount {
        utf_8_bytes32s: u64
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

    function increment_dtd_sequence(class: DTDClass, sequence: DTDInstanceCount) -> DTDInstanceCount {
        let utf_8_bytes32s: u64 = sequence.utf_8_bytes32s;
        let elements: u64 = sequence.elements;
        let attributes: u64 = sequence.attributes;
        let attribute_states: u64 = sequence.attribute_states;
        let domains: u64 = sequence.domains;
        if (class.utf8_32s) {
            utf_8_bytes32s = utf_8_bytes32s + 1u64;
        }
        if (class.elements) {
            elements = elements + 1u64;
        }
        if (class.attributes) {
            attributes = attributes + 1u64;
        }
        if (class.attribute_states) {
            attribute_states = attribute_states + 1u64;
        }
        if (class.domains) {
            domains = domains + 1u64;
        }
        return DTDInstanceCount {
            utf_8_bytes32s,
            elements,
            attributes,
            attribute_states,
            domains,
        };
    }

    // Create Public String
    transition public_utf8_to_element(collection: Collection, utf8_bytes32: utf_8_bytes32.leo/UTF8Bytes32.record, element: element.leo/Element.record) -> (utf_8_bytes32.leo/UTF8Bytes32.record, Collection) {
        // assert(!element.has_children);
        let id: u64 = collection.sequence.utf_8_bytes32s;
        let class: DTDClass = DTDClass {
            utf8_32s: true,
            elements: false,
            attributes: false,
            attribute_states: false,
            domains: false,
        };
        let counts: DTDInstanceCount = increment_dtd_sequence(class, collection.sequence);
        let target_id: u64 = element.id;
        return (utf_8_bytes32.leo/sequence_utf_8_bytes32(collection.id, id, target_id, utf8_bytes32), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: counts,
        });
    }

    // Create String
    transition utf8_to_element(collection: Collection, utf8_bytes32: utf_8_bytes32.leo/UTF8Bytes32.record, element: element.leo/Element.record,) -> (utf_8_bytes32.leo/UTF8Bytes32.record, Collection) {
        // assert(element.is_empty == true);
        let id: u64 = collection.sequence.utf_8_bytes32s;
        let class: DTDClass = DTDClass {
            utf8_32s: true,
            elements: false,
            attributes: false,
            attribute_states: false,
            domains: false,
        };
        let counts: DTDInstanceCount = increment_dtd_sequence(class, collection.sequence);
        let target_id: u64 = element.id;
        return (utf_8_bytes32.leo/sequence_utf_8_bytes32(collection.id, id, target_id, utf8_bytes32), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: counts,
        });
    }

    // Create Public Namespace

    // Create Public Element
    transition public_element_to_element(collection: Collection, element: element.leo/Element.record, target: element.leo/Element.record) -> (element.leo/Element.record, Collection) {
        // assert(element.data.no_children == true);
        let id: u64 = collection.sequence.elements;
        let class: DTDClass = DTDClass {
            utf8_32s: false,
            elements: true,
            attributes: false,
            attribute_states: false,
            domains: false,
        };
        let counts: DTDInstanceCount = increment_dtd_sequence(class, collection.sequence);
        return (element.leo/sequence_element(collection.id, id, element, target), Collection {
            owner: collection.owner,
            gates: collection.gates,
            public_registry: collection.public_registry,
            id: collection.id,
            domain_id: collection.domain_id,
            class: collection.class,
            sequence: counts,
        });
    }

    // Create Element

    // Create Public Attribute

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
                utf_8_bytes32s: 0u64,
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