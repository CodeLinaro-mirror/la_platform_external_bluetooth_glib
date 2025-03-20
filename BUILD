load("@bazel_skylib//rules:run_binary.bzl", "run_binary")
load("@rules_cc//cc:defs.bzl", "cc_library", "objc_library")
load("@rules_python//python:defs.bzl", "py_binary")
load(":common_headers.bzl", "common_os_headers", "common_os_includes", "generate_test_rules")

objc_library(
    name = "glib-darwin",
    srcs = [
        "glib/gosxutils.m",
        "os/darwin/config.h",
        "os/darwin/glib/glibconfig.h",
    ] + glob(["glib/*.h"]),
    copts = [
        "-DGLIB_COMPILATION",
        "-D_GNU_SOURCE",
        "-DG_DISABLE_CAST_CHECKS",
        '-DGLIB_CHARSETALIAS_DIR=""',
        "-I $(execpath os/darwin)",
        "-I $(execpath os/darwin/glib)",
    ],
    data = [
        # These paths are here so we can use them in copts with $(execpath ...)
        "os/darwin",
        "os/darwin/glib",
    ],
    includes = [
        ".",
    ],
)

py_binary(
    name = "gen-visibility-macros",
    srcs = ["tools/gen-visibility-macros.py"],
)

run_binary(
    name = "gen_visibility_gmodule",
    outs = ["gmodule/gmodule-visibility.h"],
    args = [
        "2.77.2",
        "visibility-macros",
        "GMODULE",
        "$(location gmodule/gmodule-visibility.h)",
    ],
    tool = ":gen-visibility-macros",
)

cc_library(
    name = "gmodule-static",
    srcs = [
        "gmodule/gmodule.c",
        "gmodule/gmodule-deprecated.c",
    ] + glob([
        "glib/*.h",
        "glib/deprecated/*.h",
    ]) + common_os_headers() + select({
        "@platforms//os:windows": ["gmodule/gmodule-win32.h"],
        "//conditions:default": [],
    }),
    hdrs = [
        "glib.h",
        "gmodule/gmodule.h",
        "gmodule/gmodule-visibility.h",
    ] + common_os_headers() + select({
        "@platforms//os:windows": [],
        "//conditions:default": ["gmodule/gmodule-dl.c"],
    }),
    copts = [
        "-Wno-#pragma-messages",
        "-Wno-implicit-function-declaration",
    ],
    defines = [
        "GMODULE_STATIC_COMPILATION",
    ],
    includes = ["glib"] + common_os_includes(),
    local_defines = [
        "_GNU_SOURCE",
        "G_DISABLE_CAST_CHECKS",
        "GMODULE_COMPILATION",
    ],
    visibility = ["//visibility:public"],
    deps = [":glib-static"],
)

cc_library(
    name = "gmodule-shared",
    srcs = [
        "gmodule/gmodule.c",
        "gmodule/gmodule-deprecated.c",
    ] + glob([
        "glib/*.h",
        "glib/deprecated/*.h",
    ]) + common_os_headers() + select({
        "@platforms//os:windows": ["gmodule/gmodule-win32.h"],
        "//conditions:default": [],
    }),
    hdrs = [
        "glib.h",
        "gmodule/gmodule.h",
        "gmodule/gmodule-visibility.h",
    ] + common_os_headers() + select({
        "@platforms//os:windows": [],
        "//conditions:default": ["gmodule/gmodule-dl.c"],
    }),
    copts = [
        "-Wno-#pragma-messages",
        "-Wno-implicit-function-declaration",
    ],
    includes = ["glib"] + common_os_includes(),
    local_defines = [
        "_GNU_SOURCE",
        "G_DISABLE_CAST_CHECKS",
        "GMODULE_COMPILATION",
    ],
    visibility = ["//visibility:public"],
    deps = [":glib-static"],
)

# This is a windows only library that providing common gnu based printing
cc_library(
    name = "gnulib",
    srcs = [
        "glib.h",
        "glib/gnulib/asnprintf.c",
        "glib/gnulib/isnan.c",
        "glib/gnulib/printf.c",
        "glib/gnulib/printf-args.c",
        "glib/gnulib/printf-frexp.c",
        "glib/gnulib/printf-frexpl.c",
        "glib/gnulib/printf-parse.c",
        "glib/gnulib/vasnprintf.c",
        "glib/gnulib/xsize.c",
    ] + glob(
        [
            "glib/gnulib/*.h",
            "glib/*.h",
            "glib/deprecated/*.h",
        ],
        exclude = [
            "glib/gnulib/printf-frexp.h",
        ],
    ),
    hdrs = [
        "glib/gnulib/printf-frexp.c",
        "glib/gnulib/printf-frexp.h",
        "os/windows/config.h",
        "os/windows/glib/glibconfig.h",
        "os/windows/glib/gnulib/gnulib_math.h",
    ],
    includes = [
        "os/windows",
        "os/windows/glib",
        "os/windows/glib/gnulib",
    ],
    local_defines = [
        "_GNU_SOURCE",
        "G_DISABLE_CAST_CHECKS",
        "GCC_LINT=1",
        "GLIB_COMPILATION",
        "HAVE_ISNAN_IN_LIBC",
        "HAVE_ISNAND_IN_LIBC",
        "HAVE_ISNANF_IN_LIBC",
        "HAVE_ISNANL_IN_LIBC",
    ],
    visibility = ["//visibility:public"],
)

# Windows only dirent implementation
cc_library(
    name = "dirent",
    srcs = ["glib/dirent/dirent.c"],
    hdrs = [
        "glib/dirent/dirent.h",
    ],
    defines = [
        "UNICODE",
        "_UNICODE",
    ],
    includes = ["glib/dirent"],
    visibility = ["//visibility:public"],
)

glib_sourceset = [
    "glib/garcbox.c",
    "glib/garray.c",
    "glib/gasyncqueue.c",
    "glib/gatomic.c",
    "glib/gbacktrace.c",
    "glib/gbase64.c",
    "glib/gbitlock.c",
    "glib/gbookmarkfile.c",
    "glib/gbytes.c",
    "glib/gcharset.c",
    "glib/gchecksum.c",
    "glib/gconvert.c",
    "glib/gdataset.c",
    "glib/gdate.c",
    "glib/gdatetime.c",
    "glib/gdir.c",
    "glib/genviron.c",
    "glib/gerror.c",
    "glib/gfileutils.c",
    # "ggettext.c", # This requires the gettext packages.
    "glib/ghash.c",
    "glib/ghmac.c",
    "glib/ghook.c",
    "glib/ghostutils.c",
    "glib/giochannel.c",
    "glib/gkeyfile.c",
    "glib/glib-init.c",
    "glib/glib-private.c",
    "glib/glist.c",
    "glib/gmain.c",
    "glib/gmappedfile.c",
    "glib/gmarkup.c",
    "glib/gmem.c",
    "glib/gunicollate.c",
    "glib/gmessages.c",
    "glib/gnode.c",
    "glib/goption.c",
    "glib/gpathbuf.c",
    "glib/gpattern.c",
    "glib/gpoll.c",
    "glib/gprimes.c",
    "glib/gprintf.c",
    "glib/gqsort.c",
    "glib/gquark.c",
    "glib/gqueue.c",
    "glib/grand.c",
    "glib/grcbox.c",
    "glib/grefcount.c",
    "glib/grefstring.c",
    "glib/gregex.c",
    "glib/gscanner.c",
    "glib/gsequence.c",
    "glib/gshell.c",
    "glib/gslice.c",
    "glib/gslist.c",
    "glib/gstdio.c",
    "glib/gstrfuncs.c",
    "glib/gstring.c",
    "glib/gstringchunk.c",
    "glib/gstrvbuilder.c",
    "glib/gtestutils.c",
    "glib/gthread.c",
    "glib/gthreadpool.c",
    "glib/gtimer.c",
    "glib/gtimezone.c",
    "glib/gtrace.c",
    "glib/gtranslit.c",
    "glib/gtrashstack.c",
    "glib/gtree.c",
    "glib/gunibreak.c",
    "glib/gunidecomp.c",
    "glib/guniprop.c",
    "glib/guri.c",
    "glib/gutf8.c",
    "glib/gutils.c",
    # "guuid.c", # needs libintl.h from gettext
    "glib/gvariant-core.c",
    "glib/gvariant-parser.c",
    "glib/gvariant-serialiser.c",
    "glib/gvariant.c",
    "glib/gvarianttype.c",
    "glib/gvarianttypeinfo.c",
    "glib/gversion.c",
    "glib/gwakeup.c",
    "glib/libcharset/localcharset.c",
    "gmodule/gmodule.h",
]

glib_warnings = [
    "-Winvalid-pch",
    "-Wextra",
    "-Wpedantic",
    "-fno-strict-aliasing",
    "-Wimplicit-fallthrough",
    "-Wmisleading-indentation",
    "-Wmissing-field-initializers",
    "-Wnonnull",
    "-Wunused",
    "-Wno-missing-prototypes",
    "-Wno-unused-parameter",
    "-Wno-cast-function-type",
    "-Wno-pedantic",
    "-Wno-format-zero-length",
    "-Wno-variadic-macros",
    "-Werror=format=2",
    "-Werror=init-self",
    "-Werror=missing-include-dirs",
    "-Werror=pointer-arith",
    "-Werror=unused-result",
    "-Wstrict-prototypes",
    "-Wno-bad-function-cast",
    "-Werror=implicit-function-declaration",
    "-Wduplicate-decl-specifier",
    "-Werror=pointer-sign",
    "-Wno-string-plus-int",
]

cc_library(
    name = "glib-static",
    srcs = glib_sourceset + select({
        "@platforms//os:macos": [
            "glib/giounix.c",
            "glib/glib-unix.c",
            "glib/glib-unixprivate.h",
            "glib/gspawn.c",
            "glib/gthread-posix.c",
        ],
        "@platforms//os:windows": [
            "glib/giowin32.c",
            "glib/gspawn-win32.c",
            "glib/gthread-win32.c",
            "glib/gwin32.c",
        ],
        "@platforms//os:linux": [
            "glib/giounix.c",
            "glib/gjournal-private.c",
            "glib/glib-unix.c",
            "glib/glib-unixprivate.h",
            "glib/gspawn.c",
            "glib/gthread-posix.c",
        ],
        "//conditions:default": [],
    }) + glob(
        [
            "glib/*.h",
            "glib/gnulib/*.h",
            "glib/deprecated/*.h",
            "glib/libcharset/*.h",
        ],
        exclude = [
            "glib/glib-unixprivate.h",
            "glib/glib-visibility.h",
        ],
    ) + common_os_headers(),
    hdrs = [
        "glib.h",
        "glib/glib-visibility.h",
    ],
    copts = glib_warnings + select({
        # Needed for using <glib/xxx> vs "glib/xxxx"
        "@platforms//os:macos": [
            "-fvisibility=hidden",
            "-std=gnu99",
            "-I $(execpath os/darwin)",
            "-I $(execpath os/darwin/glib)",
            "-I $(execpath os/darwin/gmodule)",
            "-I $(execpath glib)",
            "-I $(execpath .)",
        ],
        "@platforms//os:windows": [
            "-Wno-inconsistent-dllimport",
            "-Wno-implicit-fallthrough",
            "-Wno-unused-function",
            "-Wno-#pragma-messages",
        ],
        "@platforms//os:linux": [
            "-fvisibility=hidden",
            "-std=gnu99",
        ],
        "//conditions:default": [],
    }),
    data = [
        # These paths are here so we can use them in copts with $(execpath ...)
        "os/darwin",
        "os/darwin/glib",
        "os/darwin/gmodule",
        "os/windows/gmodule",
        "glib",
        ".",
    ],
    defines = [
        "GLIB_STATIC_COMPILATION",
    ],
    includes = [
        ".",
        "glib",
        "gmodule",
    ] + common_os_includes(),
    linkopts = select({
        "@platforms//os:windows": [
            "-DEFAULTLIB:ws2_32.lib",
            "-DEFAULTLIB:User32.lib",
            "-DEFAULTLIB:Shell32.lib",
            "-DEFAULTLIB:Ole32.lib",
            "-DEFAULTLIB:Advapi32.lib",
        ],
        "//conditions:default": ["-pthread"],
    }),
    linkstatic = True,
    local_defines = [
        "GLIB_COMPILATION",
        "_GNU_SOURCE",
        "G_DISABLE_CAST_CHECKS",
        'GLIB_CHARSETALIAS_DIR=\\"\\"',
    ],
    visibility = ["//visibility:public"],
    deps = select({
        "@platforms//os:macos": [":glib-darwin"],
        "@platforms//os:windows": [
            ":dirent",
            ":gnulib",
        ],
        "//conditions:default": [],
    }) + [
        "@pcre2",
    ],
)

cc_library(
    name = "glib-shared",
    srcs = glib_sourceset + select({
        "@platforms//os:macos": [
            "glib/giounix.c",
            "glib/glib-unix.c",
            "glib/glib-unixprivate.h",
            "glib/gspawn.c",
            "glib/gthread-posix.c",
        ],
        "@platforms//os:windows": [
            "glib/giowin32.c",
            "glib/gspawn-win32.c",
            "glib/gthread-win32.c",
            "glib/gwin32.c",
        ],
        "@platforms//os:linux": [
            "glib/giounix.c",
            "glib/gjournal-private.c",
            "glib/glib-unix.c",
            "glib/glib-unixprivate.h",
            "glib/gspawn.c",
            "glib/gthread-posix.c",
        ],
        "//conditions:default": [],
    }) + glob(
        [
            "glib/*.h",
            "glib/gnulib/*.h",
            "glib/deprecated/*.h",
            "glib/libcharset/*.h",
        ],
        exclude = [
            "glib/glib-unixprivate.h",
            "glib/glib-visibility.h",
        ],
    ) + common_os_headers(),
    hdrs = [
        "glib.h",
        "glib/glib-visibility.h",
    ],
    copts = glib_warnings + select({
        # Needed for using <glib/xxx> vs "glib/xxxx"
        "@platforms//os:macos": [
            "-fvisibility=hidden",
            "-std=gnu99",
            "-I $(execpath os/darwin)",
            "-I $(execpath os/darwin/glib)",
            "-I $(execpath os/darwin/gmodule)",
            "-I $(execpath glib)",
            "-I $(execpath .)",
        ],
        "@platforms//os:windows": [
            "-Wno-inconsistent-dllimport",
            "-Wno-implicit-fallthrough",
            "-Wno-unused-function",
            "-Wno-#pragma-messages",
        ],
        "@platforms//os:linux": [
            "-fvisibility=hidden",
            "-std=gnu99",
        ],
        "//conditions:default": [],
    }),
    data = [
        # These paths are here so we can use them in copts with $(execpath ...)
        "os/darwin",
        "os/darwin/glib",
        "os/darwin/gmodule",
        "os/windows/gmodule",
        "glib",
        ".",
    ],
    includes = [
        ".",
        "glib",
        "gmodule",
    ] + common_os_includes(),
    linkopts = [
        "-DEFAULTLIB:ws2_32.lib",
        "-DEFAULTLIB:User32.lib",
        "-DEFAULTLIB:Shell32.lib",
        "-DEFAULTLIB:Ole32.lib",
        "-DEFAULTLIB:Advapi32.lib",
    ],
    local_defines = [
        "GLIB_COMPILATION",
        "_GNU_SOURCE",
        "G_DISABLE_CAST_CHECKS",
        'GLIB_CHARSETALIAS_DIR=\\"\\"',
    ],
    visibility = ["//visibility:public"],
    deps = select({
        "@platforms//os:macos": [":glib-darwin"],
        "@platforms//os:windows": [
            ":dirent",
            ":gnulib",
        ],
        "//conditions:default": [],
    }) + [
        "@pcre2",
    ],
)

cc_shared_library(
    name = "glib-2.0",
    visibility = ["//visibility:public"],
    deps = [":glib-shared"],
)

cc_shared_library(
    name = "gmodule-2.0",
    visibility = ["//visibility:public"],
    deps = [":gmodule-shared"],
)

glib_tests = [
    "array-test",
    "asyncqueue",
    "atomic",
    "base64",
    "bitlock",
    "bookmarkfile",
    "bytes",
    "cache",
    "charset",
    "checksum",
    "collate",
    "completion",
    "cond",
    "convert",
    "dataset",
    "dir",
    "error",
    "fileutils",
    "guuid",
    "gvariant",
    "hash",
    "hmac",
    "hook",
    "hostutils",
    "io-channel-basic",
    "io-channel",
    "keyfile",
    "list",
    "logging",
    "macros",
    "mainloop",
    "mappedfile",
    "mapping",
    "markup",
    "markup-parse",
    "markup-collect",
    "markup-escape",
    "markup-subparser",
    "max-version",
    "memchunk",
    "mem-overflow",
    "mutex",
    "node",
    "once",
    "onceinit",
    "option-context",
    "option-argv0",
    "overflow",
    "overflow-fallback",
    "pathbuf",
    "pattern",
    "private",
    "protocol",
    "queue",
    "rand",
    "rcbox",
    "rec-mutex",
    "refcount",
    "refcount-macro",
    "refstring",
    "regex",
    "relation",
    "rwlock",
    "scannerapi",
    "search-utils",
    "sequence",
    "shell",
    "slice",
    "slist",
    "sort",
    "strfuncs",
    "string",
    "strvbuilder",
    "testing",
    "test-printf",
    "thread",
    "thread-deprecated",
    "thread-pool",
    "thread-pool-slow",
    "timeout",
    "timer",
    "tree",
    "types",
    "utf8-performance",
    "utf8-pointer",
    "utf8-validate",
    "utf8-misc",
    "utils",
    "utils-isolated",
    "unicode",
    "unicode-encoding",
    "unicode-normalize",
    "uri",
    "1bit-mutex",
    "642026",
]

generate_test_rules(glib_tests)
