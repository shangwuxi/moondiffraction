# External metadata catalog

Fuzzy matches are not direct overlap; source-inspected neighbors named in duplicate-check.

|Package|Version|Repository|Metadata capability boundary|
|---|---|---|---|
|2d5rrr333/mtab|0.4.0|https://github.com/2d5rrr333/mtab|MoonBit-powered browser start page: clock with lunar calendar, bookmark grid, multi-engine search, wallpapers — all core logic in MoonBit (wasm-gc), DOM as a thin shell.|
|AlexenderSokolov/moonflowgraph|0.3.0|https://github.com/AlexenderSokolov/moonflowgraph|A MoonBit task graph and provenance trace library for reproducible research and agent workflows.|
|Bobojy00/moonbit_factory_graph|0.2.1|https://github.com/Bobojy00/moonbit-factory-graph|Industrial plant topology, multi-layer material/control/energy flow modeling and failure propagation graph engine in MoonBit.|
|CAIMEOX/moon_floating|0.3.1|https://github.com/CAIMEOX/mbmath.git|Arbitrary-precision real, complex, interval, and numerical computing for MoonBit|
|CAIMEOX/symbit|0.5.10|https://github.com/CAIMEOX/symbit.git|A symbolic mathematics library for Moonbit.|
|FrozenLemonTee/LunarFormulas|0.3.1|https://github.com/FrozenLemonTee/LunarFormulas|Unit-checked engineering formula objects built on LunarUnits.|
|FrozenLemonTee/LunarUncertainty|0.1.1|https://github.com/FrozenLemonTee/LunarUncertainty|Unit-aware measured values and standard uncertainty propagation for MoonBit.|
|FrozenLemonTee/LunarUnits|0.1.9|https://github.com/FrozenLemonTee/LunarUnits|A runtime dimension-checked physical quantity and unit system for MoonBit.|
|FrozenLemonTee/formulas-calculator|0.1.2|https://github.com/FrozenLemonTee/formulas-calculator|A small LunarFormulas-powered formula calculation CLI.|
|FrozenLemonTee/formulas-calculator-web|0.1.2|https://github.com/FrozenLemonTee/formulas-calculator-web|A lightweight MoonBit-powered web interface for formulas-calculator.|
|FrozenLemonTee/units-converter|0.1.0|https://github.com/FrozenLemonTee/units-converter|A small LunarUnits-powered unit conversion CLI.|
|FrozenLemonTee/units-converter-web|0.1.0|https://github.com/FrozenLemonTee/units-converter-web|A lightweight MoonBit-powered web interface for units-converter.|
|Hhsqoo/moon-collections|0.4.1|https://github.com/Hhsqoo/moon-collections|High-performance collection data structures for MoonBit, including ordered maps and sets, bitsets, deques, caches, heaps, and AVL trees.|
|IvanAXu/BioSeqs|0.1.9|||
|JSJ222/tus-core|0.1.0|https://github.com/JSJ222/MoonTusCore|Framework-neutral tus 1.0 resumable upload protocol state machine for MoonBit|
|Juwan-Hwang/moon-certified|0.1.1|https://github.com/Juwan-Hwang/moon-certified|Core algorithms and data structures for MoonBit — partially formally verified|
|KKKIIO/selene|0.37.5|https://github.com/kkkiio/selene.git|ECS game engine in MoonBit|
|Kai-Junhan/moonbit-motion-lab|0.1.1|https://github.com/Kai-Junhan/moonbit-motion-lab|Motion curve toolkit for MoonBit: parameterized curves, cubic Bezier, sampling, diagnostics, and animation value generation|
|LAOBIAO656/moonreplaykit|0.2.0|https://github.com/LAOBIAO656/MoonReplayKit|Deterministic state-machine replay, checkpoint validation and divergence diagnostics for MoonBit.|
|Lfan-ke/moondb|0.1.7|https://github.com/Lfan-ke/moonorm|The standard database-access interface for MoonBit — the driver↔query-layer contract, transliterated from Go's database/sql/driver and Python's DB-API 2.0. ORMs (moonorm) build on it; drivers (moon-sqlite / moon-postgres / moon-mysql) implement it.|
|Lfan-ke/moonkoog|0.4.0|https://github.com/Lfan-ke/moonkoog|moonkoog — a MoonBit port of JetBrains Koog (1.1.1): a type-safe agent-orchestration framework. The prompt/message model, LLM client contract, tool registry with a JSON-schema descriptor model, and the AIAgent tool-calling loop (Koog's singleRunStrategy), built to compose with the moon-heke full-stack suite.|
|Lfan-ke/moonrpc|0.10.0|https://github.com/Lfan-ke/moonrpc|moonrpc — a real gRPC implementation for MoonBit (← gRPC). v0.8.1 adds Channel::stream_take, which drives a streaming call inline — no background reader — and returns once it has collected a bounded number of reply messages, so a caller can consume the first N of an unbounded subscription (etcd's Watch, a long server-streaming feed) and close, keeping the whole exchange in one task. v0.8.0 completes the client channel stack. Load balancing picks a READY sub-connection per call (pick_first or round_robin) from a connection pool that tracks each address through the gRPC connectivity states (IDLE/CONNECTING/READY/TRANSIENT_FAILURE/SHUTDOWN); a ManagedChannel dials several backends over real sockets and routes calls through the picker. Name resolution self-builds a DNS message codec (RFC 1035, A/AAAA with name compression) and a UDP resolver, so dns_connect turns a hostname into the backends it dials. Retry and hedging policies drive re-issue and parallel attempts — hedging fires a fresh attempt every hedging delay and commits on the first fatal status, cancelling the rest. Client keepalive pings an idle connection and closes it on a missed ACK. A multiplexed channel (MuxChannel) carries many concurrent calls over one connection through a shared read pump with per-stream inboxes and serialized writes, drives keepalive, and supports interactive bidirectional streaming — send while receiving, replies read message by message. v0.7.0 adds per-message gzip: a self-built DEFLATE (RFC 1951, stored/fixed/dynamic-Huffman) and gzip (RFC 1952, CRC-32 + ISIZE) reader that decompresses gzip requests on the server and gzip responses on the client, and client-side retry with exponential backoff bounded by the call deadline. It also hardens every decoder against malformed input: the gRPC length prefix, HPACK integer/string, protobuf, and health decoders now reject an out-of-range or overflowing length instead of aborting; flow-control windows saturate rather than wrap; peer SETTINGS are validated; the client reassembles a response header block across CONTINUATION; and header blocks and message sizes are capped. v0.6.1 self-builds a pure protobuf wire runtime (PbWriter/PbReader for varint, zigzag, fixed32/64, and length-delimited fields) and Server Reflection: a descriptor model and the grpc.reflection.v1.ServerReflection service (with its v1alpha alias) answering ListServices, FileContainingSymbol, and FileByFilename. v0.6 added the client half — a real Channel, a long-lived multiplexed h2c connection over @socket.Tcp driven by a pure H2Client engine symmetric to the server — plus the grpc.health.v1.Health service, server interceptors, -bin metadata, google.rpc.Status rich errors, and client-side grpc-timeout enforcement. The server engine (H2Server) serves all four call kinds over the self-built HTTP/2 (h2c) transport, driving the RFC 7540 frame layer, the stream state machine, complete HPACK (RFC 7541, with Huffman + dynamic table), and connection- and stream-level flow control. Includes the shared length-prefixed framing and the 17-code gRPC status model.|
|Lfan-ke/raft-moonbit|0.5.2|https://github.com/Lfan-ke/raft-moonbit|Raft consensus algorithm implemented in MoonBit.|
|Luna-Flow/floating|0.8.0|https://github.com/Luna-Flow/floating|Arbitrary-precision binary, decimal, and ball arithmetic for MoonBit, with checked operations and explicit numeric semantics.|
|Luna-Flow/linear-algebra|0.4.7|https://github.com/Luna-Flow/linear-algebra|Trait-oriented linear algebra foundations for MoonBit, with checked APIs, backend wrappers, and mutable/immutable dense matrix and vector types.|
|Luna-Flow/luna-poly|0.2.0|https://github.com/Luna-Flow/luna-poly|Immutable and mutable polynomial libraries for MoonBit with canonical dense, sparse, and context-aware representations.|
|Luna-Flow/mare_mark|0.3.0|https://github.com/Luna-Flow/mare_mark|Reproducible benchmarking, statistical comparison, tuning, and self-contained reports for MoonBit payloads.|
|Luna-Flow/type_theory|0.2.0|https://github.com/Luna-Flow/type_theory|A formal semantic substrate for Luna-Flow symbolic computation, with binding, substitution, rewriting, evaluation strategies, and lambda/type-theoretic cores.|
|Lyl66655/moonbit-workflow-engine|0.1.4|https://github.com/Lyl66655/moonbit-statemachine|A hierarchical finite state machine (HSM) and workflow execution engine for MoonBit|
|MYmodddd/moonslide|0.1.0|https://github.com/MYmodddd/moonslide||
|Magic486/moon_mutest|0.1.7|https://github.com/Magic486/moon_mutest|Mutation testing toolkit for MoonBit projects|
|Milky2018/css|0.5.3|https://github.com/Milky2018/svg|CSS parser, selector, cascade, and computed-style core maintained for Milky2018/svg|
|Milky2018/machv|0.12.6|https://github.com/Milky2018/wasmoon.git|Target-neutral semantic machine IR|
|Milky2018/milkir|0.15.0|https://github.com/Milky2018/wasmoon.git|Reusable Cranelift-like SSA intermediate representation|
|Milky2018/moon_elk|0.2.4|https://github.com/moonbit-community/moon_elk.git|A MoonBit port of Eclipse Layout Kernel (ELK).|
|Milky2018/moon_rodio|0.3.5|https://github.com/moonbit-community/moon_rodio|Native-only MoonBit port of Rust rodio with playback pipeline, source effects, and WAV/MP3/FLAC/Vorbis/MP4A decoding.|
|Milky2018/moon_taffy|0.5.3|https://github.com/moonbit-community/moon_taffy|MoonBit port of the Rust crate taffy (v0.5.x)|
|Milky2018/pptz|0.7.1|https://github.com/moonbit-community/pptz.git|PowerPoint Zero: a portable MoonBit PPTX generator driven by YAML deck and page sources.|
|Milky2018/pthread|0.1.1||Don't use it in production!|
|Milky2018/window|0.6.1|https://github.com/moonbit-community/window.git|A MoonBit port of winit with a native macOS event loop and windowing backend.|
|Mostan-303/moonbit-cog|0.2.0|https://github.com/Mostan-303/moonbit-cog|Cloud-Optimized GeoTIFF and Multispectral Remote Sensing Engine in MoonBit|
|Nanaloveyuki/BitLogger|0.8.1|https://github.com/Nanaloveyuki/BitLogger|A structured logger for MoonBit.|
|Nanaloveyuki/parsec|0.1.3|https://github.com/Nanaloveyuki/parsec|Composable, token-generic parsers for MoonBit.|
|OldPigxjk/moon_toolkit|0.1.2|https://github.com/OldPigxjk/moon_toolkit|MoonBit general graph algorithm toolkit|
|Oyc996/moonwatermarkkit|0.2.0|https://github.com/Oyc996/MoonWatermarkKit|Event-time watermark, lateness, and window assignment primitives for MoonBit.|
|P7001/moon-proxyproto|0.1.1|https://github.com/P7001/moon-proxyproto|Strict HAProxy PROXY protocol v1/v2 codec, streaming decoder, TLV parser, and CRC32C validator for MoonBit.|
|QuietlyChan/moonai|0.1.0|https://github.com/QuietlyChan/moonai|Unified, provider-neutral AI SDK for MoonBit inspired by Vercel AI SDK 7|
|R00TK17/moonreader|0.1.3|https://github.com/R00TK17/MoonReader|MoonReader — 纯 MoonBit 实现的文件内容读取库（TXT / CSV / JSON / JSONL / XML / Markdown / ZIP / TAR / DOCX / XLSX / PPTX / PDF，中文文件名友好）|
|Ridge-Lab/moonwavkit|0.1.3|https://github.com/Ridge-Lab/MoonWavKit.git|MoonBit-native WAV parser, PCM decoder, waveform analysis, validation, and audio utility toolkit.|
|Rz-coder8848/moon-fsm|0.3.0|https://github.com/Rz-coder8848/MoonBit-FSM|An auditable, type-safe workflow state machine library for MoonBit.|
|SUIKKKA/shiftweave|0.1.1|https://github.com/SUIKKKA/wb|Explainable workforce scheduling and minimal-disruption repair engine|
|SupremeHuaji/MoonElec|0.1.0|https://github.com/SupremeHuaji/MoonElec.git|A comprehensive electrical engineering calculation library for circuit analysis and power systems.|
|Suquster/moonbit-pathfinding|0.2.0|https://github.com/Suquster/moonbit-pathfinding|A MoonBit pathfinding and graph algorithms library with executable documentation, runtime-checked proof predicates, and multi-backend verification gates. Built for OSC 2026.|
|Tino-hue/depsight|0.6.0|https://github.com/Tino-hue/moonmark|Dependency health diagnostic tool for the MoonBit ecosystem|
|YM-ai-nb/rectloom|0.1.0|https://github.com/YM-ai-nb/rectloom.git|Deterministic rectangle packing and layout verification toolkit for MoonBit|
|ZSeanYves/doc_parser|0.1.1|https://github.com/ZSeanYves/markitdown.git|MoonBit-native document structure foundation for source-native parsing, inspect, validation, and custom tooling|
|ZSeanYves/markitdown|0.5.3|https://github.com/ZSeanYves/markitdown.git|A MoonBit-native document-to-Markdown converter with multi-format parsing, metadata, assets, batch conversion, and validation tooling|
|Zy789kl/moon-change-point|0.3.1|https://github.com/Zy789kl/moon-change-point|Production-oriented MoonBit change-point detection, streaming windows, multivariate monitoring, replay, SLO and alert routing|
|amor2025/moonNum|0.1.0||NumPy 的 Moonbit 移植 —— 多维数组、线性代数、FFT、随机数|
|black-duck666/moontxnkit|0.4.0|https://github.com/black-duck666/MoonTxnKit|Deterministic atomic state transitions, MVCC transactions and logical recovery for MoonBit.|
|bobzhang/bap|0.2.2|||
|bobzhang/games|0.9.33|https://github.com/bobzhang/games||
|bobzhang/loop_invariants_data_structures|0.11.1|https://github.com/moonbit-community/loop_invariants|Data structures with loop-invariant explanations|
|bobzhang/loop_invariants_dp|0.14.1|https://github.com/moonbit-community/loop_invariants|Dynamic programming algorithms with loop-invariant explanations|
|bobzhang/loop_invariants_geometry|0.13.1|https://github.com/moonbit-community/loop_invariants|Computational geometry algorithms with loop-invariant explanations|
|bobzhang/loop_invariants_graph|0.17.1|https://github.com/moonbit-community/loop_invariants|Graph and tree algorithms with loop-invariant explanations|
|bobzhang/loop_invariants_math|0.16.1|https://github.com/moonbit-community/loop_invariants|Mathematical algorithms with loop-invariant explanations|
|bobzhang/loop_invariants_string|0.15.1|https://github.com/moonbit-community/loop_invariants|String algorithms with loop-invariant explanations|
|bobzhang/loop_invariants_techniques|0.17.1|https://github.com/moonbit-community/loop_invariants|General algorithmic techniques with loop-invariant explanations|
|bobzhang/openseek|0.3.1|https://github.com/bobzhang/openseek|DeepSeek-backed MoonBit coding agent|
|bobzhang/pagelayout|0.1.1|https://github.com/moonbitlang/office.mbt|Paginated document layout engine: format-neutral page-model IR with SVG/PDF backends.|
|bobzhang/prove|0.0.3|https://github.com/bobzhang/moonbit-proof||
|bobzhang/vg|0.3.1|https://github.com/moonbit-community/vg|Declarative 2D vector graphics library for MoonBit|
|bobzhang/zip|0.1.1|||
|brickfrog/moontrace|0.14.0|https://github.com/brickfrog/moontrace|Structured tracing for MoonBit with spans, structured fields, pluggable subscribers.|
|btlqql/moon_json_repair|0.1.0|https://github.com/btlqql/moon-json-repair|Conservative JSON syntax repair with replayable edits and explicit refusal boundaries.|
|caijiewei295/tzif-engine|0.1.0||Pure MoonBit IANA TZif v2/v3 parser and timezone conversion engine. UTC ↔ local time with full DST handling, POSIX TZ fallback, and no libc timezone API dependency.|
|chnlkw/moonxi-net|0.1.1|https://github.com/moonxi-net/moonxi-net|A deep learning training framework built with MoonBit, featuring tape-based autograd and PyTorch-like API (CPU backend)|
|chnlkw/moonxi-net-gpu|0.1.1|https://github.com/moonxi-net/moonxi-net|GPU backend: CUDA/cuDNN tensor operations and training for moonxi-net|
|clhhhhhh/moonbit-treespec|0.1.0|https://github.com/clhhhhhh/moonbit-treespec|MoonBit tree speculative decoding algorithms and reproducible offline experiments|
|cogna-dev/sbom|0.1.1|https://github.com/cogna-dev/sbom|Software Composition Analysis - SBOM generation and dependency management|
|colmugx/acp|0.2.0|https://github.com/colmugx/acp.mbt|Type-safe Agent Client Protocol (ACP) SDK for MoonBit.|
|connect0459/starlark|0.5.1|https://github.com/connect0459/starlark-mbt|The Starlark configuration language, implemented in Moonbit|
|cstoooo/moonbit-aml|0.2.0|https://github.com/cstoooo/moonbit-aml||
|cxh04/cron_mbt|0.2.4|https://github.com/cxh04/Cron-Mbt|A cron expression parser, matcher, scheduler, and CLI for MoonBit.|
|dgmlbtttt/iec104|0.2.1|https://github.com/dgmlbtttt/moonbit-iec104|Pure MoonBit IEC 60870-5-104 protocol stack and deterministic substation simulation toolkit.|
|dimon-83/mbel|0.3.3|https://github.com/dimon-83/mbel|mbel — a MoonBit expression language: Jexl-compatible dynamic evaluation with an expr-lang syntax front-end, dual tree-walk/bytecode-VM engines, predicate aggregates and resource budgets.|
|dowdiness/event-graph-walker|0.8.0|https://github.com/dowdiness/event-graph-walker|Implementation of the eg-walker CRDT algorithm with FugueMax sequence CRDT|
|dowdiness/js_engine|0.9.0|https://github.com/dowdiness/js_engine|Pure MoonBit cross-target embedded JavaScript engine|
|dxh8888/moonleasekit|0.1.0|https://github.com/dxh8888/MoonLeaseKit|Deterministic leases, fencing tokens and leader election primitives for MoonBit.|
|emptist/ibmoonc|0.1.0|https://github.com/emptist/ibmoonc|MoonBit wrapper for Interactive Brokers TWS/Gateway API with C/Native FFI socket implementation|
|emptist/ibmoonjs|0.2.7|https://github.com/emptist/ibmoonjs|JavaScript/Node.js target of ibmoon - MoonBit wrapper for IB TWS/Gateway API with JavaScript FFI socket implementation|
|emptist/ibmoonwa|0.1.0|https://github.com/emptist/ibmoonwa|MoonBit wrapper for Interactive Brokers TWS/Gateway API with WebAssembly FFI socket implementation|
|f4ah6o/encoding_sjis|0.1.0||encoding_rs準拠のShift_JISデコーダー for MoonBit|
|f4ah6o/encoding_sjis_mbt|0.1.0||encoding_rs準拠のShift_JISデコーダー for MoonBit|
|fuwasegu/moonbitap|0.1.0|https://github.com/fuwasegu/moonbitap|Bitap (Shift-Or) algorithm for fuzzy string matching with full Unicode support|
|gmlewis/step|0.1.18|https://github.com/gmlewis/moonbit-step|Port of https://github.com/tscircuit/stepts to MoonBit|
|guiqi695/moon-prometheus-sdk|0.1.0|https://github.com/guiqi695/moon-prometheus-sdk|Prometheus metrics model, registry, and OpenMetrics text exporter for MoonBit.|
|hackwaly/easing|0.1.0||Easing functions for smooth animation.|
|hackwaly/moonback|0.8.1||A web backend framework for MoonBit|
|hcrrtte/moonbit-reef-connect|0.1.2|https://github.com/hcrrtte/moonbit-reef-connect|Coral reef larval dispersal simulation and marine protected area network connectivity analysis library in MoonBit.|
|hgetty/gaitlab|0.1.2|https://github.com/hgetty/moonbit-gaitlab|MoonBit Gait Lab: A gait analysis and metrics library for running, postoperative rehabilitation, and elderly screening.|
|hjuuhj/moonbit-rulesorigin|0.1.3|https://github.com/hjuuhj/moonbit-rulesorigin|A typed MoonBit rules-of-origin and supply-chain accumulation engine.|
|hmyhmyhmyss/moontrajectory|0.1.1|https://github.com/hmyhmyhmyss/MoonTrajectory|Generic MoonBit trajectory, replay, sequence sampling, offline dataset, and reinforcement-learning training utilities.|
|hnlyxiaobing/MBOpenClacky|0.1.3|https://github.com/hnlyxiaobing/MBOpenClacky|AI Agent CLI tool rewritten in MoonBit|
|hnriiuu/moonbit_forceplate|0.1.1|https://github.com/hnriiuu/moonbit-forceplate|MoonBit sports science and biomechanics force plate signal analysis library|
|horideicom/encoding_sjis|0.1.1|https://github.com/horideicom/encoding_sjis.mbt|encoding_rs-compliant Shift_JIS decoder for MoonBit|
|hrwqe/cf_ocean|0.1.4|https://github.com/hrwqe/moonbit-cf-ocean|MoonBit CF Ocean Data Exchange and Slicing Tools for NetCDF Classic/64-bit Offset and Oceanographic Data Abstractions|
|hsy-bit/moonbit-circuit-solver|0.1.1|https://github.com/hsy-bit/moonbit-circuit-solver|SPICE-compatible Modified Nodal Analysis circuit simulator and solver written in MoonBit|
|hwlxmm/dsp|0.1.0|https://github.com/hwlxmm/moonbit-dsp|A lightweight digital signal processing and spectrum analysis library for MoonBit|
|hyl-star/moonsic|0.1.0|https://github.com/hyl-star/moonsic|A MoonBit music IR and interoperability library with MIDI, MusicXML, WAV, and browser event export.|
|ihb2032/MoonFrame|0.6.0|https://github.com/ihb2032/MoonFrame|A lightweight DataFrame and tabular-data library for MoonBit|
|illusory0x0/inspect|0.1.1|https://github.com/illusory0x0/illu-inspect.mbt|A powerful quotation meta programming library that hacks MoonBit's snapshot test system, allowing you to customize `moon test` behavior with automatic source file updates and enhanced testing capabilities.|
|jdjjttr/montecarlo|0.1.0|https://github.com/jdjjttr/moonbit-montecarlo|Reproducible financial Monte Carlo simulation framework in MoonBit|
|justjavac/keepawake|0.1.4|https://github.com/justjavac/moonbit-keepawake|Native keep-awake guards for MoonBit on Windows, Linux, and macOS.|
|justjavac/num_cpus|0.1.9|https://github.com/justjavac/moonbit-num-cpus|Get the number of CPU cores available on the system.|
|kokic/uml|0.3.0|https://github.com/kokic/uml||
|lampclaw/i18n|0.9.1|https://github.com/lampclaw/moonbit-i18n|Typed internationalization, MF2 formatting, and catalog tooling for MoonBit|
|lcyllp/moonbit-nlse-ssfm|0.1.0|https://github.com/lcyllp/moonbit-nlse-ssfm|Nonlinear Fiber Optics and Optical Pulse Propagation Split-Step Fourier Simulator in MoonBit|
|lfbnntr/moonbit-fish-stock|0.1.2|https://github.com/lfbnntr/moonbit-fish-stock|Fishery stock assessment and management strategy simulation library for MoonBit|
|liying-han/moonbit-energybalance|0.2.3|https://github.com/liying-han/moonbit-energybalance|A MoonBit library for process energy balance, thermodynamic property estimates, equipment screening, reaction heat, and process analysis.|
|lkdrt/palette_forge|0.1.0|https://github.com/lkdrt/moonbit-palette-forge|面向设计系统的高级调色与调和工具 - Advanced Color Palette & Harmony Engine for Design Systems in MoonBit|
|lllg123/moonbit-aseflow|0.3.1|https://github.com/lllg123/moonbit-aseflow|A MoonBit pipeline for Aseprite JSON sprite animation assets.|
|lqlnvj/moonbit-biogeochem|0.1.2|https://github.com/lqlnvj/moonbit-biogeochem|MoonBit Marine Biogeochemical Box Model Engine: Configurable NPZD, oxygen depletion, and carbon cycle simulation framework.|
|lwmvr/moonbit-fixedincome|0.2.1|https://github.com/lwmvr/moonbit-fixedincome|Fixed-income cash-flow generation and pricing primitives in MoonBit.|
|lxyhgvb/moonbit-radioframe|0.2.0|https://github.com/lxyhgvb/moonbit-radioframe|MoonBit wireless frame, link simulation, security, routing, and 6LoWPAN toolkit|
|lxz123411/moonrrule|0.1.0|https://github.com/lxz123411/1234|A timezone-safe recurrence and scheduling engine for MoonBit|
|manabeai/ac-library-mbt|0.1.0||A complete MoonBit port of AtCoder Library v1.6|
|marianoguerra/shrubbery|0.1.1|https://github.com/marianoguerra/shrubbery-mb|Shrubbery notation for MoonBit: parser, source-faithful and reformatting printers, and structured diagnostics|
|marianoguerra/tutuca|0.56.0|https://github.com/marianoguerra/tutuca-moonbit|MoonBit port of the tutuca UI framework (value language, templates, vdom, components, app runtime, lint, CLI)|
|marianoguerra/wax|0.2.2|https://github.com/marianoguerra/wax-mb|The Wax language in MoonBit: parser, formatter, type checker, and wasm/wat emitters|
|mizchi/anim3d|0.2.0|https://github.com/mizchi/kagura|3D transform / animation / skeleton primitives for MoonBit: Transform hierarchies, keyframed animations, skeletal rigs and skinning weights. Built on mizchi/geom and mizchi/mesh3d.|
|mizchi/bitx_rebase_ai|0.46.4|https://github.com/mizchi/bit-vcs|AI-assisted rebase helpers (extension module for mizchi/bit)|
|mizchi/crater-dom|0.19.0|https://github.com/mizchi/crater|DOM, HTML, AOM, and scheduling packages for crater|
|mizchi/crater-painter|0.19.0|https://github.com/mizchi/crater|Paint tree, image output, and SVG packages for crater|
|mizchi/crater-webvitals|0.19.0|https://github.com/mizchi/crater|Web Vitals metrics helpers for crater|
|mizchi/experimental_crypto|0.0.2|https://github.com/mizchi/experimental_crypto|EXPERIMENTAL — pure-MoonBit cryptography / PKI / JOSE building blocks. Educational reference, not production-grade. No warranty.|
|mizchi/flaker|0.3.1|https://github.com/mizchi/flaker|flaker core computation engine|
|mizchi/geom|0.2.0|https://github.com/mizchi/kagura|Geometry / spatial math primitives for 2D + 3D games: Vec2 / Vec3 / Vec4, Mat4, Quaternion, 2D Path and Camera2D. Zero dependencies (only moonbitlang/core).|
|mizchi/js|0.12.2|https://github.com/mizchi/js.mbt|js bindings for builtins/web/node/deno/bun (browser APIs split to mizchi/js_browser)|
|mizchi/kagura_core|0.2.0|https://github.com/mizchi/kagura|Core math, camera, input, mesh, animation, and transform contracts for Kagura|
|mizchi/kagura_engine|0.2.0|https://github.com/mizchi/kagura|Rendering, runtime, platform, asset, audio, and glTF infrastructure for Kagura|
|mizchi/kagura_game|0.2.0|https://github.com/mizchi/kagura|Gameplay, scene, and game-specific helpers for Kagura|
|mizchi/luna|0.25.0|https://github.com/mizchi/luna.mbt|Fine-grained reactive UI library for Moonbit/JS|
|mizchi/mars|0.3.12|https://github.com/mizchi/mars.mbt|Hono-inspired MoonBit web framework with trie routing, middleware, SSE, and mizchi/x HTTP backend for native and Node.js|
|mizchi/npm_typed|0.1.15|https://github.com/mizchi/npm_typed.mbt|Typed npm library bindings(40+) for js backend|
|mizchi/syntree|0.2.4|https://github.com/mizchi/syntree.mbt|Incremental syntax tree and highlighting toolkit for MoonBit|
|mizchi/vfs|0.2.3|https://github.com/mizchi/vfs|Cross-platform virtual filesystem with pluggable backends|
|mizchi/x|0.6.1|https://github.com/mizchi/x|Cross-platform MoonBit compatibility facades with native delegation and accelerated JS implementations for async IO, bytes, regexp, and JSON.|
|mjfmjf879/moonbit_constraint|0.1.0|https://github.com/mjfmjf879/moonbit-constraint|Finite-domain constraint programming library for MoonBit|
|mokomoking2501/MoonECAT|0.2.0||A modular EtherCAT master library written in MoonBit|
|mokomoking2501/fieldbus_core|0.1.0||Protocol-neutral fieldbus profile layer for Isochronon|
|mokomoking2501/isoproject|0.1.0||Headless engineering project model for Isochronon|
|mokomoking2501/lockwire|0.1.0||Deterministic run-test substrate for MoonBit|
|mokomoking2501/profinet_master|0.1.0|||
|moonbit-community/displaytext|0.1.5|https://github.com/moonbit-community/displaytext|Grapheme-aware display-cell text boundaries for terminal UIs.|
|moonbit-community/global_hotkey|0.1.14|https://github.com/moonbit-community/proton/tree/main/sys/global_hotkey|Cross-platform native global hotkey helpers for MoonBit.|
|moonbit-community/graphviz|0.1.7|https://github.com/moonbit-community/graphviz|Graphviz rewrite in MoonBit|
|moonbit-community/keepawake|0.1.14|https://github.com/moonbit-community/proton/tree/main/sys/keepawake|Native keep-awake guards for MoonBit on Windows, Linux, and macOS.|
|moonbit-community/opentelemetry|0.1.5|https://github.com/moonbit-community/opentelemetry.mbt|The MoonBit implementation of OpenTelemetry.|
|moonbit-community/proton_ext|0.2.9|https://github.com/moonbit-community/proton/tree/main/extensions|Extensions for proton examples and applications.|
|moonbit-community/proton_keepawake|0.2.9|https://github.com/moonbit-community/proton/tree/main/sys/keepawake|Native keep-awake guards for MoonBit on Windows, Linux, and macOS.|
|moonbit-community/proton_power_monitor|0.2.9|https://github.com/moonbit-community/proton/tree/main/sys/power_monitor|Native power and idle state queries for MoonBit on Windows, Linux, and macOS.|
|moonbit-community/verified|0.0.2|https://github.com/moonbit-community/verified||
|moonbitlang/core|0.1.20260908+1634b282e|https://github.com/moonbitlang/core||
|moonbitlang/editor|0.4.5|https://github.com/moonbitlang/openseek|Readonly MoonBit code viewer harness inspired by Monaco and CodeMirror.|
|moonbitlang/moonback|0.8.2|https://github.com/moonbitlang/moonback|A web backend framework for MoonBit|
|moonbitlang/ulex|0.3.29|https://github.com/moonbitlang/moonlex.git|Simple lexer generator for MoonBit.|
|moonbitlang/yacc|0.7.19|https://github.com/moonbitlang/moonyacc|A LR(1) parser generator for MoonBit programming language.|
|morning-start/mbtgraph|0.1.3|https://github.com/morning-start/mbtgraph|MoonBit 图算法库 - 完整的图数据结构和算法实现|
|mst-mkt/clipboard|0.1.1|https://github.com/mst-mkt/clipboard-mbt||
|naoto24kawa/moonqr|0.2.0|https://github.com/elchika-inc/moonqr|Pure QR code encoder/decoder written in MoonBit|
|okMambaOut/moonpetri|0.1.0|https://github.com/okMambaOut/moonpetri|Deterministic discrete Petri net modeling and reachability analysis for MoonBit|
|oyjh0381/moonlab|0.1.0|https://github.com/oyjh0381/MoonLab|Deterministic distributed-system simulation and fault injection for MoonBit|
|pk9993/moonbit-auction|0.2.0|https://github.com/pk9993/moonbit-auction|Market mechanism design and auction simulation library in MoonBit|
|pla678889/moon-experiment|0.2.3|https://github.com/pla678889/moon-experiment|A mature A/B testing analysis library for MoonBit, supporting sample size estimation, sequential testing, metrics comparison and guardrails.|
|ppyq882/moon-privacy-budget|0.1.1|https://github.com/ppyq882/moon-privacy-budget|A comprehensive, auditable Differential Privacy Budget Manager for MoonBit.|
|pzq893/moonbit-spice|0.2.0|https://github.com/pzq893/moonbit-spice||
|rinnein/moonata|0.11.0|https://github.com/rinnein/moonata|JSONata rewritten in moonbit.|
|sacckey/mahjong|0.4.0|https://github.com/sacckey/mahjong|A four-player riichi mahjong scoring and hand analysis library for MoonBit.|
|sbqrre/moonbit-mcu-hal|0.2.1|https://github.com/sbqrre/moonbit-mcu-hal|MoonBit Microcontroller Hardware Abstraction Layer & Simulation Suite|
|shaoaiwan/moonevent|0.2.0|https://github.com/shaoaiwan/1234|A MoonBit event bus and message abstraction layer for application decoupling.|
|ssqzerz/moonbit-granular|0.1.0|https://github.com/ssqzerz/moonbit-granular|Discrete Element Method (DEM) library for granular media in MoonBit focusing on particle mechanics, contact models, and micro-macro statistics.|
|t-ujiie-g/moon-pptx|0.10.0|https://github.com/t-ujiie-g/moon-pptx|Pure-MoonBit library for reading, building, and writing PPTX (OOXML) presentations with a type-safe builder API.|
|tiye/json5|0.0.3|https://github.com/worktools/json5.mbt|JSON5 parser and stringifier for MoonBit|
|tiye/respo_css|0.1.7|git@github.com:Respo/respo_css.mbt.git|Type-safe CSS styling library for Respo framework with comprehensive property definitions, enumeration values, and functional style composition tools. Provides complete CSS support including layout, typography, colors, transforms, and grid systems with MoonBit type safety.|
|totto2727/workgraph-llm|0.1.4|https://github.com/totto2727-org/workgraph|Runtime-independent typed LLM nodes for workgraph|
|ubugeeei/vapor_moon|0.1.1|https://github.com/ubugeeei/vapor-moon|Vapor Moon is a MoonBit-first Single File Component compiler and tooling layer built on top of luna.mbt.|
|ushironoko/nash-mbt|0.1.1|https://github.com/pkdxtools/nash-mbt|Zero-sum two-player matrix game solver in MoonBit: tableau simplex LP, Fictitious Play, Multiplicative Weights Update, KL/L1 divergence, exploitability, NashConv.|
|vectie/lunanexa|0.1.0|https://github.com/vectie/lunanexa|MoonBit-native model-as-a-service and cluster control plane|
|vectie/mooncast|0.2.3|https://github.com/vectie/mooncast|Systematic rights-aware long-form AIGC production pack for MoonSuite|
|vectie/moonclaw|0.1.6|https://github.com/vectie/moonclaw||
|vectie/moonfish|0.1.0|||
|vectie/moontown|0.1.6|https://github.com/vectie/moontown||
|walkzzz/image|0.4.11|https://github.com/toadium/stb-image|MoonBit image library: pure MoonBit backend for native/wasm-gc/js/wasm multi-target support.|
|walkzzz/owl_mbt|0.1.1|https://github.com/toadium/owl-mbt|Owl - OCaml Scientific Computing, pure MoonBit port (no C FFI)|
|wjcoomk/moonbit-relief|0.1.0|https://github.com/wjcoomk/moonbit-relief|Comprehensive MoonBit Safety Relief Calculation & Sizing Library for Process Safety Engineering|
|wjyupl/measure|0.1.2|https://github.com/wjyupl/moonbit-measure|Physical measurement & uncertainty evaluation library for MoonBit|
|wqbcs/moon_collections|0.2.4|https://github.com/wqbcs/moon_collections|DETERMINISTIC × VERIFIABLE × COMPOSABLE collections for MoonBit/WASM — 12 ordered structures, FNV-1a fingerprints with lazy caching (all 11 Deterministic structs), 311 tests. Same input → same output → same fingerprint, always.|
|wyhjjkk/photonics|0.1.0|https://github.com/wyhjjkk/moonbit-photonics|High-performance Transfer Matrix Method (TMM) library for thin-film, waveguide, and multi-layer photonic structure calculations in MoonBit.|
|wzzc-dev/moui|0.1.12|https://github.com/wzzc-dev/MoUI.git|MoUI is a multi-platform MoonBit GUI framework|
|ywz1314/sessionlog|0.2.4|https://github.com/ywz1314/moonbit-sessionlog|A deterministic MoonBit model and analytics library for rehabilitation session logs.|
|yyyt0807/moonmvt|0.1.0|https://github.com/yyyt0807/MoonMVT|Pure MoonBit Mapbox Vector Tile 2.1 codec and tile builder|
|zc222er/thinfilm_tmm|0.1.2|https://github.com/zc222er/moonbit-thinfilm-tmm|High-performance Pure MoonBit Transfer Matrix Method (TMM) optical simulation & parameter inversion engine|
|zhaoyuanjuns/moonbit_extractor|0.1.2|https://github.com/zhaoyuanjuns/moonbit-extractor|Extraction process calculation toolkit for liquid-liquid extraction and solid-liquid leaching|
|ziju-max/genetic_code|0.1.0|https://github.com/ziju-max/moonbit-genetic-code|Comprehensive Multi-Genetic Code Table Utility Library in MoonBit|
|zklmbq02140831/moonbit-cbtc-atp|0.1.1|https://github.com/zklmbq02140831/moonbit-cbtc-atp|CBTC/CTCS train-borne ATP overspeed protection and dynamic braking curve calculation engine in MoonBit|
|zlhahaha/moonsim|0.3.1|https://github.com/zlhahaha/moonsim|Deterministic simulation and model testing toolkit for MoonBit.|
|zploc/loci|0.1.0|https://github.com/zpc-sh/loci|Deterministic hashing, Merkle tree sealing, FST swarms, and AI inhabitation substrate for the loci runtime|