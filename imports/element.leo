// The 'element' program.
program element.aleo {

    record Element {
        owner: address,
        gates: u64,
        namespace_id: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        // dtd: Element,
        keyword: u64,
        // data: ElementInstance,
        is_root: bool,
        attribute_counter: u64,
        has_children: bool,
        content_id: u64,
    }
    
    mapping element_registry: address => u64;
    mapping public_elements: address => u64;

    transition get_element_id(element: Element) -> (u64, Element) {
        let id: u64 = element.id;
        if (id == 0u64) {
            return (0u64, element);
        }
        else {
            return (id, element);
        }
    }

    transition register_element(keyword: u64, is_root: bool, attribute_counter: u64, has_children: bool, content_id: u64) -> public Element {
        // assert(validate_schema(data));
        return Element {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_root,
            attribute_counter,
            has_children,
            content_id,
        } then finalize(self.caller, 1u64);
    }

    finalize register_element(caller: address, record_count: u64) {
        let count: u64 = Mapping::get_or_use(element_registry, caller, 0u64);
        Mapping::set(element_registry, caller, count + record_count);
    }

    transition create_public_element(keyword: u64, is_root: bool, attribute_counter: u64, has_children: bool, content_id: u64) -> public Element {
        // assert(validate_schema(data));
        return Element {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_root,
            attribute_counter,
            has_children,
            content_id,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_element(caller: address, record_count: u64) {
        let count: u64 = Mapping::get_or_use(element_registry, caller, 0u64);
        Mapping::set(element_registry, caller, count + record_count);
    }

    transition create_element(keyword: u64, is_root: bool, attribute_counter: u64, has_children: bool, content_id: u64) -> Element {
        // assert(validate_schema(data));
        return Element {
            owner: self.caller,
            gates: 0u64,
            namespace_id: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            keyword,
            is_root,
            attribute_counter,
            has_children,
            content_id,
        };
    }

    transition sequence_element(collection_id: u64, id: u64, element: Element) -> Element {
        // assert(element.namespace == 0u64);
        // assert(element.collection_id == 0u64);
        // assert(element.id == 0u64);
        // assert(element.target_id == 0u64);
        return Element {
            owner: element.owner,
            gates: element.gates,
            namespace_id: element.namespace_id,
            collection_id,
            id,
            target_id: 0u64,
            keyword: element.keyword,
            is_root: element.is_root,
            attribute_counter: element.attribute_counter,
            has_children: element.has_children,
            content_id: element.content_id,
        };
    }

    transition assign_element_to_parent(parent: Element, child: Element) -> (Element, Element) {
        // assert(parent.namespace == 0u64);
        // assert(parent.collection_id != 0u64);
        // assert((parent.is_root && parent.id == 0u64 && parent.target_id == 0u64) || (!parent.is_root && parent.id != 0u64));
        // assert(child.namespace == 0u64);
        // assert(child.collection_id != 0u64);
        // assert(child.id != 0u64);
        // assert(child.target_id == 0u64);
        return (Element {
            owner: child.owner,
            gates: child.gates,
            namespace_id: child.namespace_id,
            collection_id: child.collection_id,
            id: child.id,
            target_id: parent.id,
            keyword: child.keyword,
            is_root: child.is_root,
            attribute_counter: child.attribute_counter,
            has_children: child.has_children,
            content_id: child.content_id,
        },
        Element {
            owner: parent.owner,
            gates: parent.gates,
            namespace_id: parent.namespace_id,
            collection_id: parent.collection_id,
            id: parent.id,
            target_id: parent.target_id,
            keyword: parent.keyword,
            is_root: parent.is_root,
            attribute_counter: parent.attribute_counter,
            has_children: parent.has_children,
            content_id: parent.content_id,
        });
    }
}
