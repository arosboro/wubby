// The 'utf8' program.
program utf8.aleo {
    
    struct UTF8Encoding32 {
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

    record UTF8Bytes32 {
        owner: address,
        gates: u64,
        collection_id: u64,
        id: u64,
        target_id: u64,
        data: UTF8Encoding32,
    }

    mapping public_utf8_bytes32: address => u64;
    
    transition create_public_utf8(data: UTF8Encoding32) -> public UTF8Bytes32 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes32 {
            owner: self.caller,
            gates: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        } then finalize(self.caller, 1u64);
    }

    finalize create_public_utf8(caller: address, record_count: u64) {
        let count: u64 = Mapping::get_or_use(public_utf8_bytes32, caller, 0u64);
        Mapping::set(public_utf8_bytes32, caller, count + record_count);
    }
    
    transition create_utf8(data: UTF8Encoding32) -> UTF8Bytes32 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes32 {
            owner: self.caller,
            gates: 0u64,
            collection_id: 0u64,
            id: 0u64,
            target_id: 0u64,
            data,
        };
    }

    transition sequence_utf8(collection_id: u64, id: u64, target_id: u64, utf8: UTF8Bytes32) -> UTF8Bytes32 {
        // assert(valid_utf8_encoding(data));
        return UTF8Bytes32 {
            owner: utf8.owner,
            gates: utf8.gates,
            collection_id,
            id,
            target_id,
            data: utf8.data,
        };
    }

    function valid_utf8_encoding(a: UTF8Encoding32) -> bool {
        return a.a0 < 128u8 && a.a1 < 128u8 && a.a2 < 128u8 && a.a3 < 128u8 && a.a4 < 128u8 && a.a5 < 128u8 && a.a6 < 128u8 && a.a7 < 128u8 && a.a8 < 128u8 && a.a9 < 128u8 && a.a10 < 128u8 && a.a11 < 128u8 && a.a12 < 128u8 && a.a13 < 128u8 && a.a14 < 128u8 && a.a15 < 128u8 && a.a16 < 128u8 && a.a17 < 128u8 && a.a18 < 128u8 && a.a19 < 128u8 && a.a20 < 128u8 && a.a21 < 128u8 && a.a22 < 128u8 && a.a23 < 128u8 && a.a24 < 128u8 && a.a25 < 128u8 && a.a26 < 128u8 && a.a27 < 128u8 && a.a28 < 128u8 && a.a29 < 128u8 && a.a30 < 128u8 && a.a31 < 128u8;
    }
}
