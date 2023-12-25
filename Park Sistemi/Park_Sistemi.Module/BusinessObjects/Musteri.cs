using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.BaseImpl.EF;
using DevExpress.Persistent.Validation;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace Park_Sistemi.Module.BusinessObjects
{
    // Navigasyon çubuğunda göster.
    [NavigationItem("Kayıtlar")]

    public class Musteri : BaseObject
    {
        [FieldSize(32)]
        [RuleRequiredField]
        public virtual String Isim { get; set; }

        [FieldSize(32)]
        [RuleRequiredField]
        public virtual String SoyIsim { get; set; }

        [RuleValueComparison(ValueComparisonType.GreaterThan, 9999999999, CustomMessageTemplate = "11 Haneli TC Kimlik Numarası giriniz.")]
        [RuleValueComparison(ValueComparisonType.LessThan, 100000000000, CustomMessageTemplate = "11 Haneli TC Kimlik Numarası giriniz.")]
        [RuleUniqueValue]
        public virtual long KimlikNo { get; set; }

        [RuleValueComparison(ValueComparisonType.GreaterThan, 9999, CustomMessageTemplate = "5 Haneli Ehliyet Numarası giriniz.")]
        [RuleValueComparison(ValueComparisonType.LessThan, 100000, CustomMessageTemplate = "5 Haneli Ehliyet Numarası giriniz.")]
        [RuleUniqueValue]
        public virtual long EhliyetNo { get; set; }

        [EditorBrowsable(EditorBrowsableState.Never)]
        public String TamIsim
        {
            get
            {
                return ObjectFormatter.Format("{Isim} {SoyIsim}", this, EmptyEntriesMode.RemoveDelimiterWhenEntryIsEmpty);
            }
        }

        // Use this attribute to show or hide a column with the property's values in a List View.
        [VisibleInListView(true)]

        // Use this attribute to specify dimensions of an image property editor.
        [ImageEditor(ListViewImageEditorCustomHeight = 75, DetailViewImageEditorFixedHeight = 150)]

        public virtual MediaDataObject Photo { get; set; }

    }
}
