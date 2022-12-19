.. Copyright (c) 2022 Dimitra Karatza

   Distributed under the Boost Software License, Version 1.0. (See accompanying
   file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

*****
 Update HPX Build Environment Requirements
*****

To update the requirements of the build environment you need the command-line tool
`pip-compile.` You can follow the steps below:

1. Install the `pip-tools` package which includes `pip-compile`.

`pip install pip-tools`

2. Update the file `docs_requirements.txt` with the new package that you want to be
included in the build environment. Simply add the name of the package in the file.

3. Let `pip-compile` re-generate the file `docs_requirements.txt` with the exact
versions of the packages listed, as well as their dependencies.

`pip-compile docs_requirements.txt`
