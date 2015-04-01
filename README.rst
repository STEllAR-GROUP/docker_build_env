.. Copyright (c) 2007-2015 Louisiana State University

   Distributed under the Boost Software License, Version 1.0. (See accompanying
   file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

*****
 HPX Build Environment
*****

|circleci_status|

.. |circleci_status| image:: https://circleci.com/gh/STEllAR-GROUP/docker_build_env/tree/master.svg?style=svg
     :target: https://circleci.com/gh/STEllAR-GROUP/docker_build_env
     :alt: HPX Build Environment master branch build status

This repository automatically builds and tests a docker image that is suitable
to build HPX.

It gets built, tested and deployed with `CircleCI <https://circleci.com/gh/STEllAR-GROUP/docker_build_env>`_.

If successfully built and tested, the final image gets deployed to Docker
and can be accessed with the image name **stellargroup/build_env:debian_clang**.
