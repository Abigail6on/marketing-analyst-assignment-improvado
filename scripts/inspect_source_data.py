from pathlib import Path
import pandas as pd


def inspect_file(file_path: Path) -> pd.DataFrame:
    print("=" * 80)
    print(f"Inspecting: {file_path.name}")
    print("=" * 80)

    df = pd.read_csv(file_path)

    print(f"Shape: {df.shape[0]} rows x {df.shape[1]} columns\n")

    print("Columns:")
    for col in df.columns:
        print(f"- {col}")

    print("\nData types:")
    print(df.dtypes)

    print("\nMissing values:")
    print(df.isnull().sum())

    print("\nFirst 5 rows:")
    print(df.head())

    print("\n")
    return pd.DataFrame(
        {
            "column_name": df.columns,
            "data_type": [str(dtype) for dtype in df.dtypes],
        }
    )


def main() -> None:
    project_root = Path(__file__).resolve().parent.parent
    data_dir = project_root / "data" / "raw"

    files = [
        data_dir / "01_facebook_ads.csv",
        data_dir / "02_google_ads.csv",
        data_dir / "03_tiktok_ads.csv",
    ]

    schema_summary = {}

    for file_path in files:
        if not file_path.exists():
            raise FileNotFoundError(f"File not found: {file_path}")
        schema_summary[file_path.name] = inspect_file(file_path)

    print("=" * 80)
    print("COLUMN COMPARISON SUMMARY")
    print("=" * 80)

    all_columns = sorted(
        set().union(*[set(df["column_name"]) for df in schema_summary.values()])
    )

    comparison_df = pd.DataFrame({"column_name": all_columns})

    for file_name, df in schema_summary.items():
        comparison_df[file_name] = comparison_df["column_name"].isin(df["column_name"])

    print(comparison_df.to_string(index=False))


if __name__ == "__main__":
    main()