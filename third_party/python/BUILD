package(
    default_visibility = ["PUBLIC"],
    python_wheel_repo = "https://get.please.build/third_party/python/py3",
)

# REPOS = [
#     "https://get.please.build/third_party/python/py27",
#     "https://get.please.build/third_party/python/py34",
#     "https://get.please.build/third_party/python/py35",
#     "https://get.please.build/third_party/python/py36",
#     "https://get.please.build/third_party/python/py37",
# ]

python_wheel(
    name = "xmlrunner",
    package_name = "unittest_xml_reporting",
    hashes = ["sha1: 62e71134eb068413e40fe4d973451c0e4931db5a"],
    version = "1.11.0",
    deps = [":six"],
)

python_wheel(
    name = "six",
    outs = ["six.py"],
    version = "1.11.0",
)

python_wheel(
    name = "requests",
    version = "2.5.0",
)

python_wheel(
    name = "colorlog",
    version = "3.1.4",
)

python_wheel(
    name = "dateutil",
    package_name = "python_dateutil",
    version = "2.4.0",
)

python_wheel(
    name = "protobuf",
    outs = ["google"],
    version = "3.6.1",
    deps = [":six"],
)

#python_multiversion_wheel(
#    name = "coverage",
#    repos = REPOS,
#    version = "4.3.4",
#)

python_wheel(
    name = "attrs",
    outs = ["attr"],
    version = "17.3.0",
)

python_wheel(
    name = "pluggy",
    version = "0.6.0",
)

python_wheel(
    name = "py",
    version = "1.5.2",
)

python_wheel(
    name = "funcsigs",
    version = "1.0.2",
)

python_wheel(
    name = "pkg_resources",
    package_name = "setuptools",
    version = "33.1.1",
)

python_wheel(
    name = "pytest",
    outs = [
        "_pytest",
        "pytest.py",
    ],
    version = "3.3.0",
    deps = [
        ":attrs",
        ":funcsigs",
        ":pkg_resources",
        ":pluggy",
        ":py",
        ":six",
    ],
)

python_wheel(
    name = "behave",
    outs = [
        "behave",
    ],
    version = "1.2.6",
    deps = [
        ":colorama",
        ":enum34",
        ":parse",
        ":parse_type",
        ":six",
        ":traceback2",
        ":win_unicode_console",
    ],
)

python_wheel(
    name = "parse",
    outs = [
        "parse.py",
    ],
    version = "1.8.2",
)

python_wheel(
    name = "parse_type",
    version = "0.4.2",
)

python_wheel(
    name = "traceback2",
    licences = ["PSF"],
    version = "1.4.0",
)

python_wheel(
    name = "enum34",
    package_name = "enum",
    outs = ["enum"],
    version = "1.1.6",
)

python_wheel(
    name = "win_unicode_console",
    version = "0.5",
)

python_wheel(
    name = "colorama",
    version = "0.3.9",
)

python_wheel(
    name = "absl",
    package_name = "absl_py",
    version = "0.5.0",
    deps = [":six"],
)

pip_library(
    name = "numpy",
    test_only = True,
    version = "1.14.0",
    zip_safe = False,
)

pip_library(
    name = "tensorflow",
    test_only = True,
    version = "1.4.0",
    deps = [
        ":numpy",
        ":protobuf",
    ],
)

pip_library(
    name = "pytz",
    test_only = True,
    version = "2018.4",
)

pip_library(
    name = "pandas",
    test_only = True,
    version = "0.22.0",
    deps = [
        ":dateutil",
        ":numpy",
        ":pytz",
        ":six",
    ],
)

pip_library(
    name = "scipy",
    test_only = True,
    version = "1.1.0",
    zip_safe = False,
    deps = [":numpy"],
)

pip_library(
    name = "boto3",
    version = "1.9.235",
    visibility = ["PUBLIC"],
    deps = [":dateutil",":urllib3",":jmespath",":six"],
    zip_safe = False,
)

pip_library(
    name = "botocore",
    version = "1.12.235",
)

pip_library(
    name = "urllib3",
    version = "1..25.6",
)

pip_library(
    name = "jmespath",
    version = "0.9.4",
)

pip_library(
    name = "hcl",
    package_name = "pyhcl",
    version = "0.3.12",
    visibility = ["PUBLIC"],
    deps = [":ply"],
    zip_safe = False,
)

pip_library(
    name = "app_mobile",
    version = "1.0.1",
    install_subdirectory = True,
    repo = "http://https://github.com/tonygyerr/wildfly",
    outs = ["Dockerfile"],
    visibility = ["PUBLIC"],
)