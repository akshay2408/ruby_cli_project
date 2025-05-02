
# ShiftCare Client Search CLI

[![Ruby Version](https://img.shields.io/badge/ruby-3.2.2-red.svg)](https://www.ruby-lang.org/en/downloads/)
[![Build Status](https://github.com/<username>/<repo>/actions/workflows/test.yml/badge.svg)](https://github.com/<username>/<repo>/actions)

A **Ruby-based interactive command-line tool** for working with client data.

This CLI tool allows users to:

- Search for clients based on `full_name`
- Identify duplicate clients based on email addresses
- Access a help menu for usage instructions

It uses a **modular, testable architecture** with an adapter-based design that supports multiple data sources.
Both **URLs and local paths** can be used to fetch data.

---

## Requirements

- Ruby 3.2.2
- Bundler

## Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone <repo-link>
   cd search
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Run the CLI**:

   ```bash
   ruby bin/search
   ```

---

## Usage Instructions

Once the CLI is set up, run:

```bash
./bin/search
```

You will see:

```bash
--- ShiftCare Client Search CLI ---
Choose an option: (Press ↑/↓ arrow to move and Enter to select)
‣ Search
  Duplicate
  Help
  Exit
```

---

### 1. Search Menu

```bash
Choose an option: Search
Enter search query for full name: joh

Result found:
id: 1
full_name: John Doe
email: john.doe@gmail.com
```

---

### 2. Duplicate Menu

```bash
Choose an option: Duplicate

Duplicate groups found for email:

Email: jane.smith@yahoo.com (2 occurrences)
 - Record #1
   id: 2
   full_name: Jane Smith
   email: jane.smith@yahoo.com
 - Record #2
   id: 15
   full_name: Another Jane Smith
   email: jane.smith@yahoo.com
```

---

### 3. Help Menu

```bash
Choose an option: Help

--- ShiftCare Client Search CLI Help ---

This tool allows you to search and analyze the clients dataset (clients.json).

Options:
  - Search   : Search clients by full name
  - Duplicate: Find duplicate records by email
  - Help     : Show this help menu
  - Exit     : Quit the application

Example usage:
  $ bin/search
  Choose an option: → Search
  Enter search query for full name: John Doe
```

---

## Assumptions and Design Decisions

- **Data Source**: Client data is available at
  `https://appassets02.shiftcare.com/manual/clients.json`

- **Client Structure**: Each client record includes `id`, `full_name`, and `email`

- **Duplicate Logic**: Clients with the same email are considered duplicates

- **Offline Support**: You can save client data to a local file and configure the adapter to load from a file for offline use

---

## Known Limitations

- **Duplicate detection**: Only email is used to detect duplicates. Support for multiple fields could be added.

- **Limited Search**: Currently supports searching by `full_name` only.
  Advanced filtering (e.g., multiple fields) is not yet implemented.

---

## Future Improvements

- **Advanced Search**: Add pattern (regex) search support for flexible querying

- **Dynamic Search Field Selection**: Let users select the search field at runtime (e.g., `id`, `email`, `full_name`)

- **Pagination**: Add pagination support for large datasets

---

## Running Tests

To run the test suite:

```bash
bundle exec rspec
```
