Feature: Merge Articles
    As a blog administrator
    In order to gather articles with the same topic
    I want to be able to merge articles

    Background: articles, users and comments have been added to database
        Given the blog is set up

        Given the following users exist:
            | id  | profile_id | login   | name  | password    | email                   | state  |           
            | 2   | 2          | ben2    | Ben   | 456456      | ben@amazon.com          | active |
            | 3   | 3          | drew3   | Drew  | 789789      | drew@cal.edu            | active |


        Given the following articles exist:
            | id | title    | author | user_id | body     | allow_comments | published | published_at        | state     | type    |
            | 4  | Article1 | ben2   | 2       | Content1 | true           | true      | 2013-23-08 21:30:00 | published | Article |
            | 5  | Article2 | drew3  | 3       | Content2 | true           | true      | 2013-25-08 22:00:00  | published| Article |

        Given the following comments exist:
            | id | type    | author | body     | article_id | user_id | created_at          |
            | 5  | Comment | ben2   | Comment1 | 3          | 3       | 2013-25-08 21:30:00 |
            | 6  | Comment | drew3  | Comment2 | 4          | 3       | 2013-27-08 22:00:00 |

    Scenario: A non-admin cannot merge articles
        Given I am logged in as "ben2" with password "456456"
        And I am on the Edit Page of Article with id 4
        Then I should not see "Merge Articles"

    Scenario: An admin can merge articles
        Given I am logged in as "admin" with password "aaaaaaaa"
        And I am on the Edit Page of Article with id 4
        Then I should see "Merge Articles"
        When I fill in "merge_with" with "5"
        And I press "Merge"
        Then I should be on admin content page


    Scenario: The merged article should contain the text of both previous articles
        Given the articles with ids 4 and 5 were merged
        And I am on the home page
        Then I should see "Article1"
        When I follow "Article1"
        And I should see "Content1"
        And I should see "Content2"


    Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article
        Given the articles with ids 4 and 5 were merged
        And I am on the home page
        Then I should see "Article1"
        When I follow "Article1"
        Then I should see "Comment1"
        And I should see "Comment2"

    Scenario: The title of the new article should be the title from either one of the merged articles
        Given the articles with ids 4 and 5 were merged
        And I am on the home page
        Then I should see "Article1"
        And I should not see "Article2"
