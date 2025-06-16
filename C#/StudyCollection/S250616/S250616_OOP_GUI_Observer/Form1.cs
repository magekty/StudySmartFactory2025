using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250616_OOP_GUI_Observer
{
    public partial class Form1 : Form
    {
        private NewsPublisher publisher = new NewsPublisher();
        private NewsSubscriber subscriber1, subscriber2, subscriber3, subscriber4;
        public Form1()
        {
            InitializeComponent();
            subscriber1 = new NewsSubscriber(lblSub1);
            subscriber2 = new NewsSubscriber(lblSub2);
            subscriber3 = new NewsSubscriber(lblSub3);
            subscriber4 = new NewsSubscriber(lblSub4);
        }
        private void btnPublish_Click(object sender, EventArgs e)
        {
            string news = txtNews.Text;
            if(!string.IsNullOrEmpty(news))
            {
                publisher.NotifyObservers(news);
                txtNews.Clear();
            }
            else
            {
                news = txtNews.Text;
                publisher.NotifyObservers(news);
            }
        }
        private void btnAddSub1_Click(object sender, EventArgs e)
        {
            publisher.AddObserver(subscriber1);
            lblSub1.Text = "구독 중";
        }

        private void btnAddSub2_Click(object sender, EventArgs e)
        {
            publisher.AddObserver(subscriber2);
            lblSub2.Text = "구독 중";
        }


        private void btnAddSub3_Click(object sender, EventArgs e)
        {
            publisher.AddObserver(subscriber3);
            lblSub3.Text = "구독 중";
        }

        private void btnAddSub4_Click(object sender, EventArgs e)
        {
            publisher.AddObserver(subscriber4);
            lblSub4.Text = "구독 중";
        }
        private void btnRemoveSub1_Click(object sender, EventArgs e)
        {
            publisher.RemoveObserver(subscriber1);
            lblSub1.Text = "구독 해지";
        }

        private void btnRemoveSub2_Click(object sender, EventArgs e)
        {
            publisher.RemoveObserver(subscriber2);
            lblSub2.Text = "구독 해지";
        }

        private void btnRemoveSub3_Click(object sender, EventArgs e)
        {
            publisher.RemoveObserver(subscriber3);
            lblSub3.Text = "구독 해지";
        }

        private void btnRemoveSub4_Click(object sender, EventArgs e)
        {
            publisher.RemoveObserver(subscriber4);
            lblSub4.Text = "구독 해지";
        }


    }

    interface INewsObserver
    {
        void Update(String News);
    }
    class NewsSubscriber : INewsObserver {
        private Label label;
        public NewsSubscriber(Label labe)
        {
            this.label = labe;
        }
        public void Update(String News) {
            label.Text = "뉴스 수신: "+News;
        }
    }
    class NewsPublisher
    {
        private List<INewsObserver> observers = new List<INewsObserver>();
        public void AddObserver(INewsObserver observer)
        {
            if(!observers.Contains(observer)) observers.Add(observer);
            
        }
        public void RemoveObserver(INewsObserver observer)
        {
            observers.Remove(observer);
        }
        public void NotifyObservers(string news)
        {
            foreach(INewsObserver observer in observers)
            {
                observer.Update(news);
            }
        }
    }
}
