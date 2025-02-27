macro_rules! id_struct {
    ($id_struct_name:ident, $struct_name:ident $(,)?) => {
        id_struct!(
            $id_struct_name,
            concat!("[`", stringify!($struct_name), "`]"),
        );

        // TODO: maybe this isn't necessary
        impl From<$struct_name> for $id_struct_name {
            fn from(value: $struct_name) -> Self {
                value.id
            }
        }
    };
    ($id_struct_name:ident, $noun:expr $(,)?) => {
        #[doc = concat!("Database ID for a ", $noun, ".")]
        #[derive(
            sqlx::Encode,
            sqlx::Decode,
            serde::Serialize,
            serde::Deserialize,
            derive_more::From,
            derive_more::Into,
            Debug,
            Copy,
            Clone,
            PartialEq,
            Eq,
            Hash,
            PartialOrd,
            Ord,
        )]
        #[sqlx(transparent)]
        #[serde(transparent)]
        pub struct $id_struct_name(pub i32);
    };
}
