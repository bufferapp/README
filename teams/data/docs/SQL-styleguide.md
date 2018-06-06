# SQL Style Guide

As a general best practice, we try to follow these style guidelines when writing SQL.

## Guiding Priciples

- **Simple**: Spend the extra time to simplify, consolidate, and organize your logic
- **Consistent**: Reduce cognitive load across queries by sticking to standards
- **Clean**: Make easy to read code. Keep in mind that code is often written once, but read many times. Assume someone will read your SQL that knows less about the data set than you (write for them not you, and the query will be much easier for everyone to read)
- **Sweat the details**: Little mistakes can add up to big problems

## Query Syntax

- **Don't capitalise SQL** clauses like select, from, ... capitals are hard on the eyes so stick with lower case throughout your SQL code
- In general, **structure your code vertically** rather than horizontally. For example, list fields vertically in a select. Generally, keep lines as short as you can
- Joins should be formatted with the join clause double indented, and the joined fields triple indented
- **Use leading commas** with a single space following. For example:

      select
        update_id
        , user_id
        , profile_id
        , date
      from updates

### White Space

Always include newlines space:

- before AND or OR
- after semicolons to separate queries for easier reading
- after each keyword definition
- after a comma when separating multiple columns into logical groups
- to separate code into related sections, which helps to ease the readability of large chunks of code

### Identation

- **Indent the beginning of each clause** in a statement equally, keeping the main clauses left justified (select, from, where, order by, etc)
- When writing a clause that is part of another clause, indent it as well. For example, `joins` are part of the `from` clause, so they should be indented after the first line
- Indentations should be one single tab over from the previous level

## Queries, Functions & Procedures

- **Utilize CTEs to compartmentalize extract and transform logic**. If the logic in a single query is hard to understand, then it is probably doing too much at once. Each function or procedure should do one thing, do it well, and do it only
- Queries should **list the specific fields that will display for results**, avoid `select *` whenever possible. Either add an additional CTE that consolidates all the specific fields to one select statement, than the final select is a `select *`, OR specifically list all fields in the final select

A great example of how to utilize CTEs to compartmentalize logic is in this example:

      with step1 as ( --extract fields
        select
          *
          , nullif(json_extract_path_text(extra_data,'age'),'') age
        from users
      )
      , step2 as ( --trasform fields
        select
          *
          , trim(first_name || ' ' || last_name), '') full_name
          , case
              when age < 18 then 'false'
              else 'true'
            end is_adult
      )
      , step3 as ( --specify fields
        select
          id
          , age
          , full_name
          , is_adult
      )
      select *
      from step3

## Resources

The following posts and resources have influenced our style guide (we have selectively used a combinaiton of elements from each):

- [Clean SQL](http://jonathansacramento.com/posts/20161119_clean_sql.html)
- [SQL Style Guide](http://www.sqlstyle.guide/)
- [SQL Coding Standards](https://www.xaprb.com/blog/2006/04/26/sql-coding-standards/)
