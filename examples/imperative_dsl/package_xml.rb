require 'rubygems'
require 'xmlsimple'
require 'pp'

config = XmlSimple.xml_in('package.xml')

def get_content element
    case element.class
    when String
        return element
    when Array
        if not element.has_key? "content"
            raise "Invalid xml hash value, dict does not have content"
        end
        return element["content"]
    else
        raise "Invalid xml hash value type #{element.class.name}"
    end
end

class PackageXML
    def initialize package_xml_path
        raw_xml = XmlSimple.xml_in(package_xml_path)
        # name
        unless raw_xml.has_key? "name"
            raise "Inavlid package.xml (#{package_xml_path}): no name"
        end
        @name = raw_xml["name"]
        raise "Inavlid name in package.xml (#{package_xml_path})" unless @name.length == 1
        @name = get_content(@name[0])
        # version
        unless raw_xml.has_key? "version"
            raise "Inavlid package.xml (#{package_xml_path}): no version"
        end
        @version = raw_xml["version"]
        raise "Inavlid version in package.xml (#{package_xml_path})" unless @version.length == 1
        @version = get_content(@version[0])
        # description
        unless raw_xml.has_key? "description"
            raise "Inavlid package.xml (#{package_xml_path}): no description"
        end
        @description = raw_xml["description"]
        raise "Inavlid description in package.xml (#{package_xml_path})" unless @description.length == 1
        @description = get_content(@description[0])
        # maintainer(s)
        unless raw_xml.has_key? "maintainer"
            raise "Inavlid package.xml (#{package_xml_path}): no maintainer"
        end
        @maintainers = raw_xml["maintainer"]
        unless @maintainers.length >= 1
            raise "Inavlid maintainer(s) in package.xml (#{package_xml_path})"
        end
        if @maintainers.kind_of? String
            @maintainers = [@maintainers]
        end
        @maintainer = @maintainers[0]
        # license
        unless raw_xml.has_key? "license"
            raise "Inavlid package.xml (#{package_xml_path}): no license"
        end
        @license = raw_xml["license"]
        raise "Inavlid license in package.xml (#{package_xml_path})" unless @license.kind_of? String
        # url(s)
        # author(s)
        # buildtool_depend(s)

    end
end

pp config
