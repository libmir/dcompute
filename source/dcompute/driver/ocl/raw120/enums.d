import derelict.opencl.cl;
import dcompute.driver.ocl.raw120.types;

enum : int_
{
    SUCCESS                                  = 0,
    DEVICE_NOT_FOUND                         = -1,
    DEVICE_NOT_AVAILABLE                     = -2,
    COMPILER_NOT_AVAILABLE                   = -3,
    MEM_OBJECT_ALLOCATION_FAILURE            = -4,
    OUT_OF_RESOURCES                         = -5,
    OUT_OF_HOST_MEMORY                       = -6,
    PROFILING_INFO_NOT_AVAILABLE             = -7,
    MEM_COPY_OVERLAP                         = -8,
    IMAGE_FORMAT_MISMATCH                    = -9,
    IMAGE_FORMAT_NOT_SUPPORTED               = -10,
    BUILD_PROGRAM_FAILURE                    = -11,
    MAP_FAILURE                              = -12,
    MISALIGNED_SUB_BUFFER_OFFSET             = -13,
    EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST= -14,
    COMPILE_PROGRAM_FAILURE                  = -15,
    LINKER_NOT_AVAILABLE                     = -16,
    LINK_PROGRAM_FAILURE                     = -17,
    DEVICE_PARTITION_FAILED                  = -18,
    KERNEL_ARG_INFO_NOT_AVAILABLE            = -19,

    INVALID_VALUE                            = -30,
    INVALID_DEVICE_TYPE                      = -31,
    INVALID_PLATFORM                         = -32,
    INVALID_DEVICE                           = -33,
    INVALID_CONTEXT                          = -34,
    INVALID_QUEUE_PROPERTIES                 = -35,
    INVALID_COMMAND_QUEUE                    = -36,
    INVALID_HOST_PTR                         = -37,
    INVALID_MEM_OBJECT                       = -38,
    INVALID_IMAGE_FORMAT_DESCRIPTOR          = -39,
    INVALID_IMAGE_SIZE                       = -40,
    INVALID_SAMPLER                          = -41,
    INVALID_BINARY                           = -42,
    INVALID_BUILD_OPTIONS                    = -43,
    INVALID_PROGRAM                          = -44,
    INVALID_PROGRAM_EXECUTABLE               = -45,
    INVALID_KERNEL_NAME                      = -46,
    INVALID_KERNEL_DEFINITION                = -47,
    INVALID_KERNEL                           = -48,
    INVALID_ARG_INDEX                        = -49,
    INVALID_ARG_VALUE                        = -50,
    INVALID_ARG_SIZE                         = -51,
    INVALID_KERNEL_ARGS                      = -52,
    INVALID_WORK_DIMENSION                   = -53,
    INVALID_WORK_GROUP_SIZE                  = -54,
    INVALID_WORK_ITEM_SIZE                   = -55,
    INVALID_GLOBAL_OFFSET                    = -56,
    INVALID_EVENT_WAIT_LIST                  = -57,
    INVALID_EVENT                            = -58,
    INVALID_OPERATION                        = -59,
    INVALID_GL_OBJECT                        = -60,
    INVALID_BUFFER_SIZE                      = -61,
    INVALID_MIP_LEVEL                        = -62,
    INVALID_GLOBAL_WORK_SIZE                 = -63,
    INVALID_PROPERTY                         = -64,
    INVALID_IMAGE_DESCRIPTOR                 = -65,
    INVALID_COMPILER_OPTIONS                 = -66,
    INVALID_LINKER_OPTIONS                   = -67,
    INVALID_DEVICE_PARTITION_COUNT           = -68,
}

enum : bool_
{
    FALSE                                    = 0,
    TRUE                                     = 1,
    BLOCKING                                 = TRUE,
    NON_BLOCKING                             = FALSE
}

enum : platform_info
{
    PLATFORM_PROFILE                         = platform_info(0x0900),
    PLATFORM_VERSION                         = platform_info(0x0901),
    PLATFORM_NAME                            = platform_info(0x0902),
    PLATFORM_VENDOR                          = platform_info(0x0903),
    PLATFORM_EXTENSIONS                      = platform_info(0x0904),
}

enum : device_type
{
    DEVICE_TYPE_DEFAULT                      = device_type(1 << 0),
    DEVICE_TYPE_CPU                          = device_type(1 << 1),
    DEVICE_TYPE_GPU                          = device_type(1 << 2),
    DEVICE_TYPE_ACCELERATOR                  = device_type(1 << 3),
    DEVICE_TYPE_CUSTOM                       = device_type(1 << 4),
    DEVICE_TYPE_ALL                          = device_type(0xFFFFFFFF),
}

enum : device_info
{
    DEVICE_TYPE                              = device_info(0x1000),
    DEVICE_VENDOR_ID                         = device_info(0x1001),
    DEVICE_MAX_COMPUTE_UNITS                 = device_info(0x1002),
    DEVICE_MAX_WORK_ITEM_DIMENSIONS          = device_info(0x1003),
    DEVICE_MAX_WORK_GROUP_SIZE               = device_info(0x1004),
    DEVICE_MAX_WORK_ITEM_SIZES               = device_info(0x1005),
    DEVICE_PREFERRED_VECTOR_WIDTH_CHAR       = device_info(0x1006),
    DEVICE_PREFERRED_VECTOR_WIDTH_SHORT      = device_info(0x1007),
    DEVICE_PREFERRED_VECTOR_WIDTH_INT        = device_info(0x1008),
    DEVICE_PREFERRED_VECTOR_WIDTH_LONG       = device_info(0x1009),
    DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT      = device_info(0x100A),
    DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE     = device_info(0x100B),
    DEVICE_MAX_CLOCK_FREQUENCY               = device_info(0x100C),
    DEVICE_ADDRESS_BITS                      = device_info(0x100D),
    DEVICE_MAX_READ_IMAGE_ARGS               = device_info(0x100E),
    DEVICE_MAX_WRITE_IMAGE_ARGS              = device_info(0x100F),
    DEVICE_MAX_MEM_ALLOC_SIZE                = device_info(0x1010),
    DEVICE_IMAGE2D_MAX_WIDTH                 = device_info(0x1011),
    DEVICE_IMAGE2D_MAX_HEIGHT                = device_info(0x1012),
    DEVICE_IMAGE3D_MAX_WIDTH                 = device_info(0x1013),
    DEVICE_IMAGE3D_MAX_HEIGHT                = device_info(0x1014),
    DEVICE_IMAGE3D_MAX_DEPTH                 = device_info(0x1015),
    DEVICE_IMAGE_SUPPORT                     = device_info(0x1016),
    DEVICE_MAX_PARAMETER_SIZE                = device_info(0x1017),
    DEVICE_MAX_SAMPLERS                      = device_info(0x1018),
    DEVICE_MEM_BASE_ADDR_ALIGN               = device_info(0x1019),
    DEVICE_MIN_DATA_TYPE_ALIGN_SIZE          = device_info(0x101A), // Deprecated in OpenCl 1.2
    DEVICE_SINGLE_FP_CONFIG                  = device_info(0x101B),
    DEVICE_GLOBAL_MEM_CACHE_TYPE             = device_info(0x101C),
    DEVICE_GLOBAL_MEM_CACHELINE_SIZE         = device_info(0x101D),
    DEVICE_GLOBAL_MEM_CACHE_SIZE             = device_info(0x101E),
    DEVICE_GLOBAL_MEM_SIZE                   = device_info(0x101F),
    DEVICE_MAX_CONSTANT_BUFFER_SIZE          = device_info(0x1020),
    DEVICE_MAX_CONSTANT_ARGS                 = device_info(0x1021),
    DEVICE_LOCAL_MEM_TYPE                    = device_info(0x1022),
    DEVICE_LOCAL_MEM_SIZE                    = device_info(0x1023),
    DEVICE_ERROR_CORRECTION_SUPPORT          = device_info(0x1024),
    DEVICE_PROFILING_TIMER_RESOLUTION        = device_info(0x1025),
    DEVICE_ENDIAN_LITTLE                     = device_info(0x1026),
    DEVICE_AVAILABLE                         = device_info(0x1027),
    DEVICE_COMPILER_AVAILABLE                = device_info(0x1028),
    DEVICE_EXECUTION_CAPABILITIES            = device_info(0x1029),
    DEVICE_QUEUE_PROPERTIES                  = device_info(0x102A),
    DEVICE_NAME                              = device_info(0x102B),
    DEVICE_VENDOR                            = device_info(0x102C),
    DRIVER_VERSION                           = device_info(0x102D),
    DEVICE_PROFILE                           = device_info(0x102E),
    DEVICE_VERSION                           = device_info(0x102F),
    DEVICE_EXTENSIONS                        = device_info(0x1030),
    DEVICE_PLATFORM                          = device_info(0x1031),
    DEVICE_DOUBLE_FP_CONFIG                  = device_info(0x1032),
    // 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG
    DEVICE_PREFERRED_VECTOR_WIDTH_HALF       = device_info(0x1034),
    DEVICE_HOST_UNIFIED_MEMORY               = device_info(0x1035),
    DEVICE_NATIVE_VECTOR_WIDTH_CHAR          = device_info(0x1036),
    DEVICE_NATIVE_VECTOR_WIDTH_SHORT         = device_info(0x1037),
    DEVICE_NATIVE_VECTOR_WIDTH_INT           = device_info(0x1038),
    DEVICE_NATIVE_VECTOR_WIDTH_LONG          = device_info(0x1039),
    DEVICE_NATIVE_VECTOR_WIDTH_FLOAT         = device_info(0x103A),
    DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE        = device_info(0x103B),
    DEVICE_NATIVE_VECTOR_WIDTH_HALF          = device_info(0x103C),
    DEVICE_OPENCL_C_VERSION                  = device_info(0x103D),
    DEVICE_LINKER_AVAILABLE                  = device_info(0x103E),
    DEVICE_BUILT_IN_KERNELS                  = device_info(0x103F),
    DEVICE_IMAGE_MAX_BUFFER_SIZE             = device_info(0x1040),
    DEVICE_IMAGE_MAX_ARRAY_SIZE              = device_info(0x1041),
    DEVICE_PARENT_DEVICE                     = device_info(0x1042),
    DEVICE_PARTITION_MAX_SUB_DEVICES         = device_info(0x1043),
    DEVICE_PARTITION_PROPERTIES              = device_info(0x1044),
    DEVICE_PARTITION_AFFINITY_DOMAIN         = device_info(0x1045),
    DEVICE_PARTITION_TYPE                    = device_info(0x1046),
    DEVICE_REFERENCE_COUNT                   = device_info(0x1047),
    DEVICE_PREFERRED_INTEROP_USER_SYNC       = device_info(0x1048),
    DEVICE_PRINTF_BUFFER_SIZE                = device_info(0x1049),
}

enum : device_fp_config
{
    FP_DENORM                                = device_fp_config(1 << 0),
    FP_INF_NAN                               = device_fp_config(1 << 1),
    FP_ROUND_TO_NEAREST                      = device_fp_config(1 << 2),
    FP_ROUND_TO_ZERO                         = device_fp_config(1 << 3),
    FP_ROUND_TO_INF                          = device_fp_config(1 << 4),
    FP_FMA                                   = device_fp_config(1 << 5),
    FP_SOFT_FLOAT                            = device_fp_config(1 << 6),
    FP_CORRECTLY_ROUNDED_DIVIDE_SQRT         = device_fp_config(1 << 7),
}

enum : device_mem_cache_type
{
    NONE                                     = device_mem_cache_type(0x0),
    READ_ONLY_CACHE                          = device_mem_cache_type(0x1),
    READ_WRITE_CACHE                         = device_mem_cache_type(0x2),
}

enum : device_local_mem_type
{
    LOCAL                                    = device_local_mem_type(0x1),
    GLOBAL                                   = device_local_mem_type(0x2),
}

enum : device_exec_capabilities
{
    EXEC_KERNEL                              = device_exec_capabilities(1 << 0),
    EXEC_NATIVE_KERNEL                       = device_exec_capabilities(1 << 1),
}

enum : command_queue_properties
{
    QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE      = command_queue_properties(1 << 0),
    QUEUE_PROFILING_ENABLE                   = command_queue_properties(1 << 1),
}

enum : context_info
{
    CONTEXT_REFERENCE_COUNT                  = context_info(0x1080),
    CONTEXT_DEVICES                          = context_info(0x1081),
    CONTEXT_PROPERTIES                       = context_info(0x1082),
    CONTEXT_NUM_DEVICES                      = context_info(0x1083),
}

enum : context_properties
{
    CONTEXT_PLATFORM                         = context_properties(0x1084),
    CONTEXT_INTEROP_USER_SYNC                = context_properties(0x1085),
}

enum : device_partition_property
{
    DEVICE_PARTITION_EQUALLY                 = device_partition_property(0x1086),
    DEVICE_PARTITION_BY_COUNTS               = device_partition_property(0x1087),
    DEVICE_PARTITION_BY_COUNTS_LIST_END      = device_partition_property(0x0),
    DEVICE_PARTITION_BY_AFFINITY_DOMAIN      = device_partition_property(0x1088),
}

enum : device_affinity_domain
{
    DEVICE_AFFINITY_DOMAIN_NUMA               = device_affinity_domain(1 << 0),
    DEVICE_AFFINITY_DOMAIN_L4_CACHE           = device_affinity_domain(1 << 1),
    DEVICE_AFFINITY_DOMAIN_L3_CACHE           = device_affinity_domain(1 << 2),
    DEVICE_AFFINITY_DOMAIN_L2_CACHE           = device_affinity_domain(1 << 3),
    DEVICE_AFFINITY_DOMAIN_L1_CACHE           = device_affinity_domain(1 << 4),
    DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE = device_affinity_domain(1 << 5),
}

enum : command_queue_info
{
    QUEUE_CONTEXT                            = command_queue_info(0x1090),
    QUEUE_DEVICE                             = command_queue_info(0x1091),
    QUEUE_REFERENCE_COUNT                    = command_queue_info(0x1092),
    QUEUE_PROPERTIES                         = command_queue_info(0x1093),
}

enum : mem_flags
{
    MEM_READ_WRITE                           = mem_flags((1 << 0)),
    MEM_WRITE_ONLY                           = mem_flags((1 << 1)),
    MEM_READ_ONLY                            = mem_flags((1 << 2)),
    MEM_USE_HOST_PTR                         = mem_flags((1 << 3)),
    MEM_ALLOC_HOST_PTR                       = mem_flags((1 << 4)),
    MEM_COPY_HOST_PTR                        = mem_flags((1 << 5)),
// reserved                                     = (1 << 6),
    MEM_HOST_WRITE_ONLY                      = mem_flags((1 << 7)),
    MEM_HOST_READ_ONLY                       = mem_flags((1 << 8)),
    MEM_HOST_NO_ACCESS                       = mem_flags((1 << 9)),
}

enum : mem_migration_flags
{
    MIGRATE_MEM_OBJECT_HOST                  = mem_migration_flags(1 << 0),
    MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED     = mem_migration_flags(1 << 1),
}

enum : channel_order
{
    R                                        = channel_order(0x10B0),
    A                                        = channel_order(0x10B1),
    RG                                       = channel_order(0x10B2),
    RA                                       = channel_order(0x10B3),
    RGB                                      = channel_order(0x10B4),
    RGBA                                     = channel_order(0x10B5),
    BGRA                                     = channel_order(0x10B6),
    ARGB                                     = channel_order(0x10B7),
    INTENSITY                                = channel_order(0x10B8),
    LUMINANCE                                = channel_order(0x10B9),
    Rx                                       = channel_order(0x10BA),
    RGx                                      = channel_order(0x10BB),
    RGBx                                     = channel_order(0x10BC),
    DEPTH                                    = channel_order(0x10BD),
    DEPTH_STENCIL                            = channel_order(0x10BE),
}

enum : channel_type
{
    SNORM_INT8                               = channel_type(0x10D0),
    SNORM_INT16                              = channel_type(0x10D1),
    UNORM_INT8                               = channel_type(0x10D2),
    UNORM_INT16                              = channel_type(0x10D3),
    UNORM_SHORT_565                          = channel_type(0x10D4),
    UNORM_SHORT_555                          = channel_type(0x10D5),
    UNORM_INT_101010                         = channel_type(0x10D6),
    SIGNED_INT8                              = channel_type(0x10D7),
    SIGNED_INT16                             = channel_type(0x10D8),
    SIGNED_INT32                             = channel_type(0x10D9),
    UNSIGNED_INT8                            = channel_type(0x10DA),
    UNSIGNED_INT16                           = channel_type(0x10DB),
    UNSIGNED_INT32                           = channel_type(0x10DC),
    HALF_FLOAT                               = channel_type(0x10DD),
    FLOAT                                    = channel_type(0x10DE),
    UNORM_INT24                              = channel_type(0x10DF),
}

enum : mem_object_type
{
    MEM_OBJECT_BUFFER                        = mem_object_type(0x10F0),
    MEM_OBJECT_IMAGE2D                       = mem_object_type(0x10F1),
    MEM_OBJECT_IMAGE3D                       = mem_object_type(0x10F2),
    MEM_OBJECT_IMAGE2D_ARRAY                 = mem_object_type(0x10F3),
    MEM_OBJECT_IMAGE1D                       = mem_object_type(0x10F4),
    MEM_OBJECT_IMAGE1D_ARRAY                 = mem_object_type(0x10F5),
    MEM_OBJECT_IMAGE1D_BUFFER                = mem_object_type(0x10F6),
}

enum : mem_info
{
    MEM_TYPE                                 = mem_info(0x1100),
    MEM_FLAGS                                = mem_info(0x1101),
    MEM_SIZE                                 = mem_info(0x1102),
    MEM_HOST_PTR                             = mem_info(0x1103),
    MEM_MAP_COUNT                            = mem_info(0x1104),
    MEM_REFERENCE_COUNT                      = mem_info(0x1105),
    MEM_CONTEXT                              = mem_info(0x1106),
    MEM_ASSOCIATED_MEMOBJECT                 = mem_info(0x1107),
    MEM_OFFSET                               = mem_info(0x1108),
}

enum : image_info
{
    IMAGE_FORMAT                             = image_info(0x1110),
    IMAGE_ELEMENT_SIZE                       = image_info(0x1111),
    IMAGE_ROW_PITCH                          = image_info(0x1112),
    IMAGE_SLICE_PITCH                        = image_info(0x1113),
    IMAGE_WIDTH                              = image_info(0x1114),
    IMAGE_HEIGHT                             = image_info(0x1115),
    IMAGE_DEPTH                              = image_info(0x1116),
    IMAGE_ARRAY_SIZE                         = image_info(0x1117),
    IMAGE_BUFFER                             = image_info(0x1118),
    IMAGE_NUM_MIP_LEVELS                     = image_info(0x1119),
    IMAGE_NUM_SAMPLES                        = image_info(0x111A),
}

enum : addressing_mode
{
    ADDRESS_NONE                             = addressing_mode(0x1130),
    ADDRESS_CLAMP_TO_EDGE                    = addressing_mode(0x1131),
    ADDRESS_CLAMP                            = addressing_mode(0x1132),
    ADDRESS_REPEAT                           = addressing_mode(0x1133),
    ADDRESS_MIRRORED_REPEAT                  = addressing_mode(0x1134),
}

enum : filter_mode
{
    FILTER_NEAREST                           = filter_mode(0x1140),
    FILTER_LINEAR                            = filter_mode(0x1141),
}

enum : sampler_info
{
    SAMPLER_REFERENCE_COUNT                  = sampler_info(0x1150),
    SAMPLER_CONTEXT                          = sampler_info(0x1151),
    SAMPLER_NORMALIZED_COORDS                = sampler_info(0x1152),
    SAMPLER_ADDRESSING_MODE                  = sampler_info(0x1153),
    SAMPLER_FILTER_MODE                      = sampler_info(0x1154),
}

enum : map_flags
{
    MAP_READ                                 = map_flags(1 << 0),
    MAP_WRITE                                = map_flags(1 << 1),
    MAP_WRITE_INVALIDATE_REGION              = map_flags(1 << 2),
}

enum : program_info
{
    PROGRAM_REFERENCE_COUNT                  = program_info(0x1160),
    PROGRAM_CONTEXT                          = program_info(0x1161),
    PROGRAM_NUM_DEVICES                      = program_info(0x1162),
    PROGRAM_DEVICES                          = program_info(0x1163),
    PROGRAM_SOURCE                           = program_info(0x1164),
    PROGRAM_BINARY_SIZES                     = program_info(0x1165),
    PROGRAM_BINARIES                         = program_info(0x1166),
    PROGRAM_NUM_KERNELS                      = program_info(0x1167),
    PROGRAM_KERNEL_NAMES                     = program_info(0x1168),
}

enum : program_build_info
{
    PROGRAM_BUILD_STATUS                     = program_build_info(0x1181),
    PROGRAM_BUILD_OPTIONS                    = program_build_info(0x1182),
    PROGRAM_BUILD_LOG                        = program_build_info(0x1183),
    PROGRAM_BINARY_TYPE                      = program_build_info(0x1184),
}

enum : program_binary_type
{
    PROGRAM_BINARY_TYPE_NONE                 = program_binary_type(0x0),
    PROGRAM_BINARY_TYPE_COMPILED_OBJECT      = program_binary_type(0x1),
    PROGRAM_BINARY_TYPE_LIBRARY              = program_binary_type(0x2),
    PROGRAM_BINARY_TYPE_EXECUTABLE           = program_binary_type(0x4),
}

enum : build_status
{
    BUILD_SUCCESS                            = build_status( 0),
    BUILD_NONE                               = build_status(-1),
    BUILD_ERROR                              = build_status(-2),
    BUILD_IN_PROGRESS                        = build_status(-3),
}

enum : kernel_info
{
    KERNEL_FUNCTION_NAME                     = kernel_info(0x1190),
    KERNEL_NUM_ARGS                          = kernel_info(0x1191),
    KERNEL_REFERENCE_COUNT                   = kernel_info(0x1192),
    KERNEL_CONTEXT                           = kernel_info(0x1193),
    KERNEL_PROGRAM                           = kernel_info(0x1194),
    KERNEL_ATTRIBUTES                        = kernel_info(0x1195),
}

enum : kernel_arg_info
{
    KERNEL_ARG_ADDRESS_QUALIFIER             = kernel_arg_info(0x1196),
    KERNEL_ARG_ACCESS_QUALIFIER              = kernel_arg_info(0x1197),
    KERNEL_ARG_TYPE_NAME                     = kernel_arg_info(0x1198),
    KERNEL_ARG_TYPE_QUALIFIER                = kernel_arg_info(0x1199),
    KERNEL_ARG_NAME                          = kernel_arg_info(0x119A),
}

enum : kernel_arg_address_qualifier
{
    KERNEL_ARG_ADDRESS_GLOBAL                = kernel_arg_address_qualifier(0x119B),
    KERNEL_ARG_ADDRESS_LOCAL                 = kernel_arg_address_qualifier(0x119C),
    KERNEL_ARG_ADDRESS_CONSTANT              = kernel_arg_address_qualifier(0x119D),
    KERNEL_ARG_ADDRESS_PRIVATE               = kernel_arg_address_qualifier(0x119E),
}

enum : kernel_arg_access_qualifier
{
    KERNEL_ARG_ACCESS_READ_ONLY              = kernel_arg_access_qualifier(0x11A0),
    KERNEL_ARG_ACCESS_WRITE_ONLY             = kernel_arg_access_qualifier(0x11A1),
    KERNEL_ARG_ACCESS_READ_WRITE             = kernel_arg_access_qualifier(0x11A2),
    KERNEL_ARG_ACCESS_NONE                   = kernel_arg_access_qualifier(0x11A3),
}

enum : kernel_arg_type_qualifier
{
    KERNEL_ARG_TYPE_NONE                     = kernel_arg_type_qualifier(0),
    KERNEL_ARG_TYPE_CONST                    = kernel_arg_type_qualifier(1 << 0),
    KERNEL_ARG_TYPE_RESTRICT                 = kernel_arg_type_qualifier(1 << 1),
    KERNEL_ARG_TYPE_VOLATILE                 = kernel_arg_type_qualifier(1 << 2),
}

enum : kernel_work_group_info
{
    KERNEL_WORK_GROUP_SIZE                   = kernel_work_group_info(0x11B0),
    KERNEL_COMPILE_WORK_GROUP_SIZE           = kernel_work_group_info(0x11B1),
    KERNEL_LOCAL_MEM_SIZE                    = kernel_work_group_info(0x11B2),
    KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE= kernel_work_group_info(0x11B3),
    KERNEL_PRIVATE_MEM_SIZE                  = kernel_work_group_info(0x11B4),
    KERNEL_GLOBAL_WORK_SIZE                  = kernel_work_group_info(0x11B5),
}

enum : event_info
{
    EVENT_COMMAND_QUEUE                      = event_info(0x11D0),
    EVENT_COMMAND_TYPE                       = event_info(0x11D1),
    EVENT_REFERENCE_COUNT                    = event_info(0x11D2),
    EVENT_COMMAND_EXECUTION_STATUS           = event_info(0x11D3),
    EVENT_CONTEXT                            = event_info(0x11D4),
}

enum : command_type
{
    COMMAND_NDRANGE_KERNEL                   = command_type(0x11F0),
    COMMAND_TASK                             = command_type(0x11F1),
    COMMAND_NATIVE_KERNEL                    = command_type(0x11F2),
    COMMAND_READ_BUFFER                      = command_type(0x11F3),
    COMMAND_WRITE_BUFFER                     = command_type(0x11F4),
    COMMAND_COPY_BUFFER                      = command_type(0x11F5),
    COMMAND_READ_IMAGE                       = command_type(0x11F6),
    COMMAND_WRITE_IMAGE                      = command_type(0x11F7),
    COMMAND_COPY_IMAGE                       = command_type(0x11F8),
    COMMAND_COPY_IMAGE_TO_BUFFER             = command_type(0x11F9),
    COMMAND_COPY_BUFFER_TO_IMAGE             = command_type(0x11FA),
    COMMAND_MAP_BUFFER                       = command_type(0x11FB),
    COMMAND_MAP_IMAGE                        = command_type(0x11FC),
    COMMAND_UNMAP_MEM_OBJECT                 = command_type(0x11FD),
    COMMAND_MARKER                           = command_type(0x11FE),
    COMMAND_ACQUIRE_GL_OBJECTS               = command_type(0x11FF),
    COMMAND_RELEASE_GL_OBJECTS               = command_type(0x1200),
    COMMAND_READ_BUFFER_RECT                 = command_type(0x1201),
    COMMAND_WRITE_BUFFER_RECT                = command_type(0x1202),
    COMMAND_COPY_BUFFER_RECT                 = command_type(0x1203),
    COMMAND_USER                             = command_type(0x1204),
    COMMAND_BARRIER                          = command_type(0x1205),
    COMMAND_MIGRATE_MEM_OBJECTS              = command_type(0x1206),
    COMMAND_FILL_BUFFER                      = command_type(0x1207),
    COMMAND_FILL_IMAGE                       = command_type(0x1208),
}

enum : int_
{
    COMPLETE                                 = 0x0,
    RUNNING                                  = 0x1,
    SUBMITTED                                = 0x2,
    QUEUED                                   = 0x3,
}

enum : buffer_create_type
{
    BUFFER_CREATE_TYPE_REGION                = buffer_create_type(0x1220),
}

enum : profiling_info
{
    PROFILING_COMMAND_QUEUED                 = profiling_info(0x1280),
    PROFILING_COMMAND_SUBMIT                 = profiling_info(0x1281),
    PROFILING_COMMAND_START                  = profiling_info(0x1282),
    PROFILING_COMMAND_END                    = profiling_info(0x1283),
}

// ext.h

// khr_fp16 extension
enum DEVICE_HALF_FP_CONFIG                   = device_info(0x1033);

// APPLE_SetMemObjectDestructor extension
enum APPLE_SetMemObjectDestructor            = 1;

// APPLE_ContextLoggingFunctions
enum APPLE_ContextLoggingFunctions           = 1;

// khr_icd extension
enum khr_icd                                 = 1;
// platform_info
enum PLATFORM_ICD_SUFFIX_KHR                 = platform_info(0x0920);
// Additional Error Codes
enum PLATFORM_NOT_FOUND_KHR                  = -1001;

// khr_initalize_memory extension
enum CONTEXT_MEMORY_INITIALIZE_KHR           = context_properties(0x200E);

// khr_terminate_context extension
enum khr_terminate_context                   = 1;
enum
{
    DEVICE_TERMINATE_CAPABILITY_KHR          = device_info(0x200F),
    CONTEXT_TERMINATE_KHR                    = context_properties(0x2010),
}

// nv_device_attribute_query extension
enum : device_info
{
    DEVICE_COMPUTE_CAPABILITY_MAJOR_NV       = device_info(0x4000),
    DEVICE_COMPUTE_CAPABILITY_MINOR_NV       = device_info(0x4001),
    DEVICE_REGISTERS_PER_BLOCK_NV            = device_info(0x4002),
    DEVICE_WARP_SIZE_NV                      = device_info(0x4003),
    DEVICE_GPU_OVERLAP_NV                    = device_info(0x4004),
    DEVICE_KERNEL_EXEC_TIMEOUT_NV            = device_info(0x4005),
    DEVICE_INTEGRATED_MEMORY_NV              = device_info(0x4006),
}

// amd_device_attribute_query extension
enum DEVICE_PROFILING_TIMER_OFFSET_AMD       = device_info(0x4036);

// ext_device_fission extension
enum ext_device_fission                      = 1;

// device_partition_property_ext extension
enum
{
    DEVICE_PARTITION_EQUALLY_EXT             = 0x4050,
    DEVICE_PARTITION_BY_COUNTS_EXT           = 0x4051,
    DEVICE_PARTITION_BY_NAMES_EXT            = 0x4052,
    DEVICE_PARTITION_BY_AFFINITY_DOMAIN_EXT  = 0x4053,
}

// clDeviceGetInfo selectors
enum
{
    DEVICE_PARENT_DEVICE_EXT                 = 0x4054,
    DEVICE_PARTITION_TYPES_EXT               = 0x4055,
    DEVICE_AFFINITY_DOMAINS_EXT              = 0x4056,
    DEVICE_REFERENCE_COUNT_EXT               = 0x4057,
    DEVICE_PARTITION_STYLE_EXT               = 0x4058,
}

// error codes
enum
{
    DEVICE_PARTITION_FAILED_EXT              = -1057,
    INVALID_PARTITION_COUNT_EXT              = -1058,
    INVALID_PARTITION_NAME_EXT               = -1059,
}

// AFFINITY_DOMAINs
enum
{
    AFFINITY_DOMAIN_L1_CACHE_EXT             = 0x1,
    AFFINITY_DOMAIN_L2_CACHE_EXT             = 0x2,
    AFFINITY_DOMAIN_L3_CACHE_EXT             = 0x3,
    AFFINITY_DOMAIN_L4_CACHE_EXT             = 0x4,
    AFFINITY_DOMAIN_NUMA_EXT                 = 0x10,
    AFFINITY_DOMAIN_NEXT_FISSIONABLE_EXT     = 0x100,
}

// device_partition_property_ext list terminators
enum
{
    PROPERTIES_LIST_END_EXT                  = (cast(device_partition_property_ext) 0),
    PARTITION_BY_COUNTS_LIST_END_EXT         = (cast(device_partition_property_ext) 0),
    PARTITION_BY_NAMES_LIST_END_EXT          = (cast(device_partition_property_ext) 0 - 1),
}


// egl.h

// Command type for events created with clEnqueueAcquireEGLObjectsKHR
enum
{
    COMMAND_EGL_FENCE_SYNC_OBJECT_KHR        = 0x202F,
    COMMAND_ACQUIRE_EGL_OBJECTS_KHR          = 0x202D,
    COMMAND_RELEASE_EGL_OBJECTS_KHR          = 0x202E,
}

// Error type for clCreateFromEGLImageKHR
enum
{
    INVALID_EGL_OBJECT_KHR                   = -1093,
    EGL_RESOURCE_NOT_ACQUIRED_KHR            = -1092,
}

// khr_egl_image extension
enum khr_egl_image                           = 1;

// khr_egl_event extension
enum khr_egl_event                           = 1;


// gl.h

// gl_object_type
enum
{
    GL_OBJECT_BUFFER                         = 0x2000,
    GL_OBJECT_TEXTURE2D                      = 0x2001,
    GL_OBJECT_TEXTURE3D                      = 0x2002,
    GL_OBJECT_RENDERBUFFER                   = 0x2003,
    GL_OBJECT_TEXTURE2D_ARRAY                = 0x200E,
    GL_OBJECT_TEXTURE1D                      = 0x200F,
    GL_OBJECT_TEXTURE1D_ARRAY                = 0x2010,
    GL_OBJECT_TEXTURE_BUFFER                 = 0x2011,
}

// gl_texture_info
enum
{
    GL_TEXTURE_TARGET                        = 0x2004,
    GL_MIPMAP_LEVEL                          = 0x2005,
    GL_NUM_SAMPLES                           = 0x2012,
}

// Additional Error Codes
enum INVALID_GL_SHAREGROUP_REFERENCE_KHR     = -1000;

// gl_context_info
enum
{
    CURRENT_DEVICE_FOR_GL_CONTEXT_KHR        = 0x2006,
    DEVICES_FOR_GL_CONTEXT_KHR               = 0x2007,
}

// Additional context_properties
enum
{
    GL_CONTEXT_KHR                           = 0x2008,
    EGL_DISPLAY_KHR                          = 0x2009,
    GLX_DISPLAY_KHR                          = 0x200A,
    WGL_HDC_KHR                              = 0x200B,
    CGL_SHAREGROUP_KHR                       = 0x200C,
}

// khr_gl_sharing extension
enum khr_gl_sharing                          = 1;


// gl_ext.h

// khr_gl_event extension
enum COMMAND_GL_FENCE_SYNC_OBJECT_KHR        = 0x200D;


// d3d10.h

// khr_d3d10_sharing extension
enum khr_d3d10_sharing                           = 1;

// Error Codes
enum
{
    INVALID_D3D10_DEVICE_KHR                     = -1002,
    INVALID_D3D10_RESOURCE_KHR                   = -1003,
    D3D10_RESOURCE_ALREADY_ACQUIRED_KHR          = -1004,
    D3D10_RESOURCE_NOT_ACQUIRED_KHR              = -1005,
}

// d3d10_device_source_nv
enum
{
    D3D10_DEVICE_KHR                             = 0x4010,
    D3D10_DXGI_ADAPTER_KHR                       = 0x4011,
}

// d3d10_device_set_nv
enum
{
    PREFERRED_DEVICES_FOR_D3D10_KHR              = 0x4012,
    ALL_DEVICES_FOR_D3D10_KHR                    = 0x4013,
}

// context_info
enum
{
    CONTEXT_D3D10_DEVICE_KHR                     = 0x4014,
    CONTEXT_D3D10_PREFER_SHARED_RESOURCES_KHR    = 0x402C,
}

// mem_info
enum MEM_D3D10_RESOURCE_KHR                      = 0x4015;

// image_info
enum IMAGE_D3D10_SUBRESOURCE_KHR                 = 0x4016;

// command_type
enum COMMAND_ACQUIRE_D3D10_OBJECTS_KHR           = 0x4017;
enum COMMAND_RELEASE_D3D10_OBJECTS_KHR           = 0x4018;


// d3d11.h

// khr_d3d11_sharing extension
enum khr_d3d11_sharing = 1;

// Error Codes
enum
{
    INVALID_D3D11_DEVICE_KHR                     = -1006,
    INVALID_D3D11_RESOURCE_KHR                   = -1007,
    D3D11_RESOURCE_ALREADY_ACQUIRED_KHR          = -1008,
    D3D11_RESOURCE_NOT_ACQUIRED_KHR              = -1009,
}

// d3d11_device_source
enum
{
    D3D11_DEVICE_KHR                             = 0x4019,
    D3D11_DXGI_ADAPTER_KHR                       = 0x401A,
}

// d3d11_device_set
enum
{
    PREFERRED_DEVICES_FOR_D3D11_KHR              = 0x401B,
    ALL_DEVICES_FOR_D3D11_KHR                    = 0x401C,
}

// context_info
enum
{
    CONTEXT_D3D11_DEVICE_KHR                     = 0x401D,
    CONTEXT_D3D11_PREFER_SHARED_RESOURCES_KHR    = 0x402D,
}

// mem_info
enum MEM_D3D11_RESOURCE_KHR                      = 0x401E;

// image_info
enum IMAGE_D3D11_SUBRESOURCE_KHR                 = 0x401F;

// command_type
enum
{
    COMMAND_ACQUIRE_D3D11_OBJECTS_KHR            = 0x4020,
    COMMAND_RELEASE_D3D11_OBJECTS_KHR            = 0x4021,
}


// dx9_media_sharing.h extension

// khr_dx9_media_sharing
enum khr_dx9_media_sharing                       = 1;

// Error Codes
enum
{
    INVALID_DX9_MEDIA_ADAPTER_KHR                = -1010,
    INVALID_DX9_MEDIA_SURFACE_KHR                = -1011,
    DX9_MEDIA_SURFACE_ALREADY_ACQUIRED_KHR       = -1012,
    DX9_MEDIA_SURFACE_NOT_ACQUIRED_KHR           = -1013,
}

// media_adapter_type_khr
enum
{
    ADAPTER_D3D9_KHR                             = 0x2020,
    ADAPTER_D3D9EX_KHR                           = 0x2021,
    ADAPTER_DXVA_KHR                             = 0x2022,
}

// media_adapter_set_khr
enum
{
    PREFERRED_DEVICES_FOR_DX9_MEDIA_ADAPTER_KHR  = 0x2023,
    ALL_DEVICES_FOR_DX9_MEDIA_ADAPTER_KHR        = 0x2024,
}

// context_info
enum
{
    CONTEXT_ADAPTER_D3D9_KHR                     = 0x2025,
    CONTEXT_ADAPTER_D3D9EX_KHR                   = 0x2026,
    CONTEXT_ADAPTER_DXVA_KHR                     = 0x2027,
}

// mem_info
enum
{
    MEM_DX9_MEDIA_ADAPTER_TYPE_KHR               = 0x2028,
    MEM_DX9_MEDIA_SURFACE_INFO_KHR               = 0x2029,
}

// image_info
enum IMAGE_DX9_MEDIA_PLANE_KHR                   = 0x202A;

// command_type
enum
{
    COMMAND_ACQUIRE_DX9_MEDIA_SURFACES_KHR       = 0x202B,
    COMMAND_RELEASE_DX9_MEDIA_SURFACES_KHR       = 0x202C,
}
