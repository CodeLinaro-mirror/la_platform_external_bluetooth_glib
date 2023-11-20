"""
Common headers and includes that are used accross many
glib like libraries
"""
# build_commons.bzl

load("@rules_cc//cc:defs.bzl", "cc_test")

def generate_test_rules(test_names):
    # Iterate over the test_names array and generate cc_test rules
    test_rules = []
    for test_name in test_names:
        test_rules.append(
            cc_test(
                name = "glib_test_" + test_name,
                srcs = ["glib/tests/" + test_name + ".c"],
                deps = [":glib-2.0"],
            ),
        )
    return test_rules

def common_os_headers():
    return select({
        "@platforms//os:macos": [
            "os/darwin/config.h",
            "os/darwin/gmodule/gmoduleconf.h",
            "os/darwin/glib/glibconfig.h",
        ],
        "@platforms//os:linux": [
            "os/linux/config.h",
            "os/linux/gmodule/gmoduleconf.h",
            "os/linux/glib/glibconfig.h",
        ],
        "@platforms//os:windows": [
            "os/windows/config.h",
            "os/windows/gmodule/gmoduleconf.h",
            "os/windows/glib/glibconfig.h",
            "os/windows/glib/gnulib/gnulib_math.h",
        ],
        "//conditions:default": [],
    })

def common_os_includes():
    return select({
        "@platforms//os:macos": [
            "os/darwin",
            "os/darwin/glib",
            "os/darwin/gmodule",
        ],
        "@platforms//os:linux": [
            "os/linux",
            "os/linux/glib",
            "os/linux/gmodule",
        ],
        "@platforms//os:windows": [
            "os/windows",
            "os/windows/glib",
            "os/windows/gmodule",
        ],
        "//conditions:default": [],
    })
