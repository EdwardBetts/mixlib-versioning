#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Author:: Christopher Maier (<cm@opscode.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Mixlib
  class Versioning
    class Format
      class SemVer < Format

        # Format that implements SemVer 2.0.0-rc.1 (http://semver.org/)
        #
        # SUPPORTED FORMATS:
        #
        #    MAJOR.MINOR.PATCH
        #    MAJOR.MINOR.PATCH-PRERELEASE
        #    MAJOR.MINOR.PATCH-PRERELEASE+BUILD
        #
        # EXAMPLES:
        #
        #    11.0.0
        #    11.0.0-alpha.1
        #    11.0.0-alpha1+20121218164140
        #    11.0.0-alpha1+20121218164140.git.207.694b062
        #
        SEMVER_REGEX = /^(\d+)\.(\d+)\.(\d+)(?:\-([\dA-Za-z\-\.]+))?(?:\+([\dA-Za-z\-\.]+))?$/

        def initialize(version)
          match = version.match(SEMVER_REGEX) rescue nil

          unless match
            raise Mixlib::Versioning::ParseError, "'#{version}' is not a valid semver version string!"
          end

          @input = version

          @major, @minor, @patch, @prerelease, @build = match[1..5]
          @major, @minor, @patch = [@major, @minor, @patch].map(&:to_i)

          @prerelease = nil if (@prerelease.nil? || @prerelease.empty?)
          @build = nil if (@build.nil? || @build.empty?)
        end

        def to_s
          @input
        end
      end
    end
  end
end
