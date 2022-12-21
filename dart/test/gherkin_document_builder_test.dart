import 'package:gherkin/ast.dart';
import 'package:gherkin/language.dart';
import 'package:gherkin/parser.dart';
import 'package:gherkin/pickles.dart';
import 'package:test/test.dart';

void main()
{
    final languages = loadGherkinLanguagesFromJsonAsset();
    final dialectProvider = GherkinDialectProvider(languages);
    final idGenerator = IdGenerator.incrementingGenerator;
    final builder = GherkinDocumentBuilder(idGenerator);
    final parser = Parser<GherkinDocument>(builder);
    final matcher = TokenMatcher(dialectProvider);
/*
    test('Is reusable', () {
        var tokenScanner = StringTokenScanner('Feature: 1');
        var d1 = parser.parse(tokenScanner, matcher);

        tokenScanner = StringTokenScanner('Feature: 2');
        var d2 = parser.parse(tokenScanner, matcher);

        expect(d1.feature.name, '1');
        expect(d2.feature.name, '2');
    } );

    test('Parses rules', () {
        var data =
            'Feature: Some rules\n'
            '\n'
            '  Background:\n'
            '    Given fb\n'
            '\n'
            '  Rule: A\n'
            '    The rule A description\n'
            '\n'
            '    Background:\n'
            '      Given ab\n'
            '\n'
            '    Example: Example A\n'
            '      Given a\n'
            '\n'
            '  Rule: B\n'
            '    The rule B description\n'
            '\n'
            '    Example: Example B\n'
            '      Given b';

        var tokenScanner = StringTokenScanner(data);
        var doc = parser.parse(tokenScanner, matcher);

        var children = doc.feature.children.toList();
        expect(children.length, 3);

        var pickleCompiler = PickleCompiler(idGenerator);
        var pickles = pickleCompiler.compile(doc, 'hello.feature');
        expect(2, pickles.length);

        expect(3, pickles.first.steps.length);

        expect(2, pickles.elementAt(1).steps.length);
    } );

    test('Parses just comments', () {
        final data = '# Just a comment';
        var tokenScanner = StringTokenScanner(data);
        var doc = parser.parse(tokenScanner, matcher);
        var children = doc.comments;
        expect(children.length, 1);
    } );

    test('Sets empty table cells', () {
        final data =
            'Feature:\n'
            '  Scenario:\n'
            '    Given a table\n'
            '      |a||b|';
        var tokenScanner = StringTokenScanner(data);
        var doc = parser.parse(tokenScanner, matcher);

        var row = doc.feature
            .children.first
            .scenario
            .steps.first
            .dataTable
            .rows.first;
        expect('a', row.cells.first.value);
        expect('', row.cells.elementAt(1).value);
        expect('b', row.cells.elementAt(2).value);
    } );

    test('Sets a table with values', () {
        final data =
            'Feature:\n'
            '  Scenario:\n'
            '    Given a table\n'
            '      |name|age|height|\n'
            '      |John| 35|  1.80|';
        var tokenScanner = StringTokenScanner(data);
        var doc = parser.parse(tokenScanner, matcher);

        var columns = doc.feature
            .children.first
            .scenario
            .steps.first
            .dataTable
            .rows.first;
        expect('name', columns.cells.first.value);
        expect('age', columns.cells.elementAt(1).value);
        expect('height', columns.cells.elementAt(2).value);

        var values = doc.feature
            .children.first
            .scenario
            .steps.first
            .dataTable
            .rows.elementAt(1);
        expect('John', values.cells.first.value);
        expect('35', values.cells.elementAt(1).value);
        expect('1.80', values.cells.elementAt(2).value);
    } );
*/
    test('Steps with values', () {
        final data =
            'Feature:\n'
            '  Scenario:\n'
            '    Given I have a "Calculator"\n'
            '    When I add 1 and 1\n'
            '    Then the sum should be 2';
        var tokenScanner = StringTokenScanner(data);
        var doc = parser.parse(tokenScanner, matcher);

        var steps = doc.feature
            .children.first
            .scenario
            .steps;
        for( var step in steps ) {
            print(step);
        }

        var pickleCompiler = PickleCompiler(idGenerator);
        var pickles = pickleCompiler.compile(doc, 'hello.feature');
        expect(2, pickles.length);

        expect(3, pickles.first.steps.length);

        expect(2, pickles.elementAt(1).steps.length);
    } );

    test('Identical steps with values', () {
        final data =
            'Feature:\n'
            '  Scenario:\n'
            '    Given I have a Calculator\n'
            '    When I add 1\n'
            '    And I add 2\n'
            '    And I add 3\n'
            '    Then the sum should be 6';
        var tokenScanner = StringTokenScanner(data);
        var doc = parser.parse(tokenScanner, matcher);

        var steps = doc.feature
            .children.first
            .scenario
            .steps;
        for( var step in steps ) {
            print(step);
        }
    } );

}
